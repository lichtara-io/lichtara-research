#!/usr/bin/env node
/**
 * Environment Variables Validation Script
 * Validates that all required environment variables are set
 */

const fs = require('fs');
const path = require('path');

// Load environment variables if .env file exists
const envPath = path.join(__dirname, '..', '.env');
if (fs.existsSync(envPath)) {
  require('dotenv').config({ path: envPath });
}

// Define required variables based on environment
const requiredVars = {
  development: [
    'NODE_ENV',
    'PORT',
    'APP_URL'
  ],
  staging: [
    'NODE_ENV',
    'PORT',
    'APP_URL',
    'DATABASE_URL'
  ],
  production: [
    'NODE_ENV',
    'PORT',
    'APP_URL',
    'DATABASE_URL',
    'JWT_SECRET',
    'ENCRYPTION_KEY'
  ]
};

// Optional but recommended variables
const recommendedVars = [
  'OPENAI_API_KEY',
  'GITHUB_TOKEN',
  'REDIS_URL',
  'SMTP_HOST',
  'SENTRY_DSN'
];

// API key patterns for validation
const apiKeyPatterns = {
  OPENAI_API_KEY: /^sk-proj-[a-zA-Z0-9]{64}$|^sk-[a-zA-Z0-9]{48}$/,
  GITHUB_TOKEN: /^ghp_[a-zA-Z0-9]{36}$|^gho_[a-zA-Z0-9]{36}$/,
  JWT_SECRET: /^.{32,}$/, // At least 32 characters
  ENCRYPTION_KEY: /^.{32}$/, // Exactly 32 characters
  WEBHOOK_SECRET: /^.{16,}$/ // At least 16 characters
};

function validateEnvironment() {
  const env = process.env.NODE_ENV || 'development';
  const required = requiredVars[env] || requiredVars.development;
  
  console.log(`🔍 Validating environment variables for: ${env.toUpperCase()}`);
  console.log('='.repeat(50));
  
  let hasErrors = false;
  let hasWarnings = false;
  
  // Check required variables
  console.log('\n📋 Required Variables:');
  required.forEach(key => {
    const value = process.env[key];
    if (!value) {
      console.log(`❌ ${key} - MISSING (REQUIRED)`);
      hasErrors = true;
    } else {
      console.log(`✅ ${key} - SET`);
    }
  });
  
  // Check recommended variables
  console.log('\n💡 Recommended Variables:');
  recommendedVars.forEach(key => {
    const value = process.env[key];
    if (!value) {
      console.log(`⚠️  ${key} - NOT SET (RECOMMENDED)`);
      hasWarnings = true;
    } else {
      console.log(`✅ ${key} - SET`);
    }
  });
  
  // Validate API key formats
  console.log('\n🔑 API Key Format Validation:');
  Object.keys(apiKeyPatterns).forEach(key => {
    const value = process.env[key];
    if (value) {
      const pattern = apiKeyPatterns[key];
      if (pattern.test(value)) {
        console.log(`✅ ${key} - Valid format`);
      } else {
        console.log(`❌ ${key} - Invalid format`);
        hasErrors = true;
      }
    }
  });
  
  // Check for common mistakes
  console.log('\n🔍 Common Issues Check:');
  
  // Check for example values
  const exampleValues = [
    'your-api-key-here',
    'your-secret-here',
    'example.com',
    'localhost',
    'test'
  ];
  
  let hasExampleValues = false;
  Object.keys(process.env).forEach(key => {
    const value = process.env[key];
    if (exampleValues.some(example => value && value.includes(example))) {
      console.log(`⚠️  ${key} - Contains example value`);
      hasExampleValues = true;
    }
  });
  
  if (!hasExampleValues) {
    console.log('✅ No example values found');
  }
  
  // Check for spaces in values
  let hasSpaces = false;
  Object.keys(process.env).forEach(key => {
    const value = process.env[key];
    if (value && (value.startsWith(' ') || value.endsWith(' '))) {
      console.log(`⚠️  ${key} - Has leading/trailing spaces`);
      hasSpaces = true;
    }
  });
  
  if (!hasSpaces) {
    console.log('✅ No leading/trailing spaces found');
  }
  
  // Summary
  console.log('\n' + '='.repeat(50));
  if (hasErrors) {
    console.log('❌ VALIDATION FAILED - Fix required variables');
    process.exit(1);
  } else if (hasWarnings) {
    console.log('⚠️  VALIDATION PASSED WITH WARNINGS');
    process.exit(0);
  } else {
    console.log('✅ VALIDATION PASSED - All good!');
    process.exit(0);
  }
}

// Helper function to check if .env file exists
function checkEnvFile() {
  const envPath = path.join(__dirname, '..', '.env');
  if (!fs.existsSync(envPath)) {
    console.log('⚠️  No .env file found. Copy .env.example to .env first:');
    console.log('   cp .env.example .env');
    console.log('');
  }
}

// Main execution
if (require.main === module) {
  checkEnvFile();
  validateEnvironment();
}

module.exports = {
  validateEnvironment,
  requiredVars,
  recommendedVars,
  apiKeyPatterns
};