#!/usr/bin/env node
/**
 * Security Scanner for Credential Leaks
 * Scans the repository for potential credential exposures
 */

const fs = require('fs');
const path = require('path');

// Patterns that might indicate credential leaks
const dangerousPatterns = [
  {
    name: 'OpenAI API Key',
    pattern: /sk-[a-zA-Z0-9]{48,}/g,
    severity: 'HIGH'
  },
  {
    name: 'OpenAI Project Key', 
    pattern: /sk-proj-[a-zA-Z0-9]{64}/g,
    severity: 'HIGH'
  },
  {
    name: 'GitHub Token',
    pattern: /ghp_[a-zA-Z0-9]{36}/g,
    severity: 'HIGH'
  },
  {
    name: 'GitHub OAuth Token',
    pattern: /gho_[a-zA-Z0-9]{36}/g,
    severity: 'HIGH'
  },
  {
    name: 'GitHub PAT',
    pattern: /github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59}/g,
    severity: 'HIGH'
  },
  {
    name: 'Google API Key',
    pattern: /AIza[0-9A-Za-z\\-_]{35}/g,
    severity: 'HIGH'
  },
  {
    name: 'AWS Access Key',
    pattern: /AKIA[0-9A-Z]{16}/g,
    severity: 'HIGH'
  },
  {
    name: 'Generic API Key',
    pattern: /api[_-]?key[s]?\s*[:=]\s*["\']?[a-zA-Z0-9]{20,}["\']?/gi,
    severity: 'MEDIUM'
  },
  {
    name: 'Generic Secret',
    pattern: /secret[s]?\s*[:=]\s*["\']?[a-zA-Z0-9]{16,}["\']?/gi,
    severity: 'MEDIUM'
  },
  {
    name: 'Generic Token',
    pattern: /token[s]?\s*[:=]\s*["\']?[a-zA-Z0-9]{16,}["\']?/gi,
    severity: 'MEDIUM'
  },
  {
    name: 'Password in Code',
    pattern: /password[s]?\s*[:=]\s*["\']?[a-zA-Z0-9!@#$%^&*()]{8,}["\']?/gi,
    severity: 'MEDIUM'
  }
];

// Files to exclude from scanning
const excludePatterns = [
  /node_modules/,
  /\.git/,
  /\.env\.example/,
  /\.env\.development/,
  /\.env\.production/,
  /CREDENTIAL_MANAGEMENT\.md/,
  /security-scan\.js/,
  /validate-env\.js/,
  /package-lock\.json/,
  /yarn\.lock/
];

// File extensions to scan
const includeExtensions = [
  '.js', '.ts', '.jsx', '.tsx',
  '.json', '.yml', '.yaml',
  '.md', '.txt', '.env',
  '.py', '.rb', '.php',
  '.go', '.rs', '.java',
  '.sh', '.bash', '.zsh'
];

function shouldScanFile(filePath) {
  // Check if file should be excluded
  if (excludePatterns.some(pattern => pattern.test(filePath))) {
    return false;
  }
  
  // Check if file has scannable extension
  const ext = path.extname(filePath);
  return includeExtensions.includes(ext) || !ext;
}

function scanFile(filePath) {
  const findings = [];
  
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    const lines = content.split('\n');
    
    dangerousPatterns.forEach(({ name, pattern, severity }) => {
      lines.forEach((line, lineNumber) => {
        const matches = line.match(pattern);
        if (matches) {
          matches.forEach(match => {
            // Skip if it's clearly an example or placeholder
            if (isExampleValue(match)) {
              return;
            }
            
            findings.push({
              file: filePath,
              line: lineNumber + 1,
              type: name,
              severity,
              match: match.substring(0, 20) + '...',
              context: line.trim()
            });
          });
        }
      });
    });
  } catch (error) {
    console.warn(`⚠️  Could not scan ${filePath}: ${error.message}`);
  }
  
  return findings;
}

function isExampleValue(value) {
  const exampleIndicators = [
    'example',
    'your-',
    'test',
    'demo',
    'placeholder',
    'sample',
    'fake',
    'dummy',
    'template',
    'xxx',
    '123'
  ];
  
  const lowerValue = value.toLowerCase();
  return exampleIndicators.some(indicator => lowerValue.includes(indicator));
}

function scanDirectory(dirPath) {
  const allFindings = [];
  
  function walkDir(currentPath) {
    const items = fs.readdirSync(currentPath);
    
    items.forEach(item => {
      const itemPath = path.join(currentPath, item);
      const stat = fs.statSync(itemPath);
      
      if (stat.isDirectory()) {
        walkDir(itemPath);
      } else if (stat.isFile() && shouldScanFile(itemPath)) {
        const findings = scanFile(itemPath);
        allFindings.push(...findings);
      }
    });
  }
  
  walkDir(dirPath);
  return allFindings;
}

function formatFindings(findings) {
  if (findings.length === 0) {
    console.log('✅ No potential credential leaks found!');
    return;
  }
  
  console.log(`⚠️  Found ${findings.length} potential security issues:\n`);
  
  // Group by severity
  const bySeverity = findings.reduce((acc, finding) => {
    if (!acc[finding.severity]) acc[finding.severity] = [];
    acc[finding.severity].push(finding);
    return acc;
  }, {});
  
  ['HIGH', 'MEDIUM', 'LOW'].forEach(severity => {
    if (!bySeverity[severity]) return;
    
    console.log(`🚨 ${severity} SEVERITY (${bySeverity[severity].length} issues):`);
    bySeverity[severity].forEach(finding => {
      console.log(`   📁 ${finding.file}:${finding.line}`);
      console.log(`   🔍 ${finding.type}: ${finding.match}`);
      console.log(`   📝 ${finding.context}`);
      console.log('');
    });
  });
}

function checkGitignore() {
  const gitignorePath = path.join(process.cwd(), '.gitignore');
  
  if (!fs.existsSync(gitignorePath)) {
    console.log('⚠️  No .gitignore file found!');
    return false;
  }
  
  const gitignoreContent = fs.readFileSync(gitignorePath, 'utf8');
  const envPatterns = ['.env', '.env.local', '.env.*.local'];
  
  const missing = envPatterns.filter(pattern => 
    !gitignoreContent.includes(pattern)
  );
  
  if (missing.length > 0) {
    console.log('⚠️  Missing .env patterns in .gitignore:');
    missing.forEach(pattern => console.log(`   - ${pattern}`));
    return false;
  }
  
  console.log('✅ .gitignore properly configured for .env files');
  return true;
}

function checkForCommittedSecrets() {
  const { execSync } = require('child_process');
  
  try {
    // Check if we're in a git repository
    execSync('git rev-parse --git-dir', { stdio: 'ignore' });
    
    // Check for .env files in git history
    const result = execSync('git log --all --full-history --grep="env" --oneline', 
      { encoding: 'utf8', stdio: 'pipe' });
    
    if (result.trim()) {
      console.log('⚠️  Found commits mentioning "env" in history:');
      console.log(result);
    }
    
    // Check current staged files
    const staged = execSync('git diff --cached --name-only', 
      { encoding: 'utf8', stdio: 'pipe' });
    
    const stagedEnvFiles = staged.split('\n')
      .filter(file => file.includes('.env') && !file.includes('.example'));
    
    if (stagedEnvFiles.length > 0) {
      console.log('🚨 WARNING: .env files are staged for commit:');
      stagedEnvFiles.forEach(file => console.log(`   - ${file}`));
      console.log('   Run: git reset HEAD <file> to unstage');
    }
    
  } catch (error) {
    console.log('ℹ️  Not a git repository or git not available');
  }
}

function main() {
  console.log('🔒 Lichtara Research Security Scanner');
  console.log('=====================================\n');
  
  const projectRoot = process.cwd();
  
  console.log('🔍 Scanning for credential patterns...');
  const findings = scanDirectory(projectRoot);
  formatFindings(findings);
  
  console.log('\n🔒 Checking .gitignore configuration...');
  checkGitignore();
  
  console.log('\n📜 Checking git history...');
  checkForCommittedSecrets();
  
  console.log('\n💡 Security Recommendations:');
  console.log('   - Never commit .env files to version control');
  console.log('   - Use .env.example for templates');
  console.log('   - Rotate any exposed credentials immediately');
  console.log('   - Use environment variables in production');
  console.log('   - Regular security audits with tools like this');
  
  if (findings.filter(f => f.severity === 'HIGH').length > 0) {
    console.log('\n🚨 HIGH SEVERITY ISSUES FOUND - Please review immediately!');
    process.exit(1);
  } else if (findings.length > 0) {
    console.log('\n⚠️  Medium/Low severity issues found - Please review');
    process.exit(1);
  } else {
    console.log('\n✅ Security scan completed - No issues found!');
    process.exit(0);
  }
}

if (require.main === module) {
  main();
}

module.exports = {
  scanDirectory,
  scanFile,
  dangerousPatterns,
  checkGitignore
};