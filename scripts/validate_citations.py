#!/usr/bin/env python3
"""
Citation Validation Script for Lichtara Research Repository

This script validates institutional citations and references throughout the
markdown files in the repository, ensuring consistency and proper formatting.
"""

import re
import os
import json
import yaml
from pathlib import Path
from typing import List, Dict, Tuple, Set
from dataclasses import dataclass


@dataclass
class CitationIssue:
    """Represents a citation validation issue"""
    file_path: str
    line_number: int
    issue_type: str
    message: str
    line_content: str


class CitationValidator:
    """Validates citations and institutional references"""
    
    def __init__(self):
        self.issues: List[CitationIssue] = []
        self.institution_patterns = {
            'professor_helio': [
                r'professor\s+h[eé]lio\s+couto',
                r'h[eé]lio\s+couto',
                r'professor\s+h[eé]lio'
            ],
            'zenodo_doi': r'10\.5281/zenodo\.\d+',
            'orcid': r'0000-\d{4}-\d{4}-\d{4}|0009-\d{4}-\d{4}-\d{4}',
            'doi_general': r'10\.\d+/.+',
            'email': r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
            'url': r'https?://[^\s<>"{}|\\^`\[\]]+',
        }
        
        # Standard formats for institutional references
        self.standard_formats = {
            'professor_helio': 'Professor Hélio Couto',
            'orcid_format': '0009-0001-9541-1835',
            'zenodo_doi': '10.5281/zenodo.16196582',
            'email_contact': 'contact@lichtara.io'
        }
    
    def validate_file(self, file_path: Path) -> None:
        """Validate citations in a single markdown file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            for line_num, line in enumerate(lines, 1):
                self._check_professor_helio_consistency(file_path, line_num, line)
                self._check_doi_format(file_path, line_num, line)
                self._check_orcid_format(file_path, line_num, line)
                self._check_email_format(file_path, line_num, line)
                self._check_url_format(file_path, line_num, line)
                
        except Exception as e:
            self.issues.append(CitationIssue(
                file_path=str(file_path),
                line_number=0,
                issue_type="file_error",
                message=f"Error reading file: {str(e)}",
                line_content=""
            ))
    
    def _check_professor_helio_consistency(self, file_path: Path, line_num: int, line: str) -> None:
        """Check for consistent formatting of Professor Hélio references"""
        line_lower = line.lower()
        
        # Find all variations of Professor Hélio references
        helio_matches = []
        for pattern in self.institution_patterns['professor_helio']:
            matches = re.finditer(pattern, line_lower)
            helio_matches.extend([(m.start(), m.end(), m.group()) for m in matches])
        
        for start, end, match in helio_matches:
            # Check if it's the standard format
            actual_text = line[start:end]
            if actual_text != self.standard_formats['professor_helio']:
                # Check if it's in a reasonable variation
                if not self._is_acceptable_helio_variation(actual_text):
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=line_num,
                        issue_type="inconsistent_helio_reference",
                        message=f"Inconsistent Professor Hélio reference. Found: '{actual_text}', Expected: '{self.standard_formats['professor_helio']}'",
                        line_content=line.strip()
                    ))
    
    def _is_acceptable_helio_variation(self, text: str) -> bool:
        """Check if a Professor Hélio variation is acceptable"""
        acceptable_variations = [
            'Professor Hélio Couto',
            'Professor Hélio',
            'Hélio Couto',
            'professor Hélio Couto',  # lowercase p acceptable in some contexts
            'professor hélio',
            'hélio couto'
        ]
        return text in acceptable_variations
    
    def _check_doi_format(self, file_path: Path, line_num: int, line: str) -> None:
        """Check DOI format and validate Zenodo DOI consistency"""
        doi_matches = re.finditer(self.institution_patterns['doi_general'], line)
        
        for match in doi_matches:
            doi = match.group()
            
            # Check if it's a Zenodo DOI
            if 'zenodo' in doi.lower():
                if not re.match(self.institution_patterns['zenodo_doi'], doi):
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=line_num,
                        issue_type="invalid_zenodo_doi",
                        message=f"Invalid Zenodo DOI format: {doi}",
                        line_content=line.strip()
                    ))
                elif doi != self.standard_formats['zenodo_doi']:
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=line_num,
                        issue_type="inconsistent_zenodo_doi",
                        message=f"Inconsistent Zenodo DOI. Found: {doi}, Expected: {self.standard_formats['zenodo_doi']}",
                        line_content=line.strip()
                    ))
    
    def _check_orcid_format(self, file_path: Path, line_num: int, line: str) -> None:
        """Check ORCID format consistency"""
        orcid_matches = re.finditer(self.institution_patterns['orcid'], line)
        
        for match in orcid_matches:
            orcid = match.group()
            if orcid != self.standard_formats['orcid_format']:
                self.issues.append(CitationIssue(
                    file_path=str(file_path),
                    line_number=line_num,
                    issue_type="inconsistent_orcid",
                    message=f"Inconsistent ORCID. Found: {orcid}, Expected: {self.standard_formats['orcid_format']}",
                    line_content=line.strip()
                ))
    
    def _check_email_format(self, file_path: Path, line_num: int, line: str) -> None:
        """Check email format and institutional email consistency"""
        email_matches = re.finditer(self.institution_patterns['email'], line)
        
        for match in email_matches:
            email = match.group()
            # Check for institutional emails that should be consistent
            if 'lichtara' in email.lower():
                if email != self.standard_formats['email_contact']:
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=line_num,
                        issue_type="inconsistent_institutional_email",
                        message=f"Inconsistent institutional email. Found: {email}, Expected: {self.standard_formats['email_contact']}",
                        line_content=line.strip()
                    ))
    
    def _check_url_format(self, file_path: Path, line_num: int, line: str) -> None:
        """Check URL format for broken or malformed URLs"""
        url_matches = re.finditer(self.institution_patterns['url'], line)
        
        for match in url_matches:
            url = match.group()
            # Basic URL validation
            if not self._is_valid_url(url):
                self.issues.append(CitationIssue(
                    file_path=str(file_path),
                    line_number=line_num,
                    issue_type="malformed_url",
                    message=f"Potentially malformed URL: {url}",
                    line_content=line.strip()
                ))
    
    def _is_valid_url(self, url: str) -> bool:
        """Basic URL validation"""
        # Check for common URL issues
        if url.endswith(('.', ',', ';', ')', ']')):
            return False
        if '..' in url:
            return False
        return True
    
    def validate_citation_metadata(self, repo_root: Path) -> None:
        """Validate citation metadata files"""
        citation_cff = repo_root / 'CITATION.cff'
        codemeta_json = repo_root / 'codemeta.json'
        
        # Validate CITATION.cff
        if citation_cff.exists():
            self._validate_citation_cff(citation_cff)
        else:
            self.issues.append(CitationIssue(
                file_path=str(citation_cff),
                line_number=0,
                issue_type="missing_citation_file",
                message="CITATION.cff file not found",
                line_content=""
            ))
        
        # Validate codemeta.json
        if codemeta_json.exists():
            self._validate_codemeta_json(codemeta_json)
        else:
            self.issues.append(CitationIssue(
                file_path=str(codemeta_json),
                line_number=0,
                issue_type="missing_codemeta_file",
                message="codemeta.json file not found",
                line_content=""
            ))
    
    def _validate_citation_cff(self, file_path: Path) -> None:
        """Validate CITATION.cff format and content"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                citation_data = yaml.safe_load(f)
            
            # Required fields
            required_fields = ['cff-version', 'message', 'title', 'authors']
            for field in required_fields:
                if field not in citation_data:
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=0,
                        issue_type="missing_required_field",
                        message=f"Missing required field in CITATION.cff: {field}",
                        line_content=""
                    ))
            
            # Validate DOI format
            if 'doi' in citation_data:
                doi = citation_data['doi']
                if not re.match(self.institution_patterns['zenodo_doi'], doi):
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=0,
                        issue_type="invalid_doi_in_citation_cff",
                        message=f"Invalid DOI format in CITATION.cff: {doi}",
                        line_content=""
                    ))
                    
        except Exception as e:
            self.issues.append(CitationIssue(
                file_path=str(file_path),
                line_number=0,
                issue_type="citation_cff_parse_error",
                message=f"Error parsing CITATION.cff: {str(e)}",
                line_content=""
            ))
    
    def _validate_codemeta_json(self, file_path: Path) -> None:
        """Validate codemeta.json format and content"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                codemeta_data = json.load(f)
            
            # Check for required fields
            required_fields = ['@context', '@type', 'name', 'description']
            for field in required_fields:
                if field not in codemeta_data:
                    self.issues.append(CitationIssue(
                        file_path=str(file_path),
                        line_number=0,
                        issue_type="missing_required_field",
                        message=f"Missing required field in codemeta.json: {field}",
                        line_content=""
                    ))
                    
        except Exception as e:
            self.issues.append(CitationIssue(
                file_path=str(file_path),
                line_number=0,
                issue_type="codemeta_parse_error",
                message=f"Error parsing codemeta.json: {str(e)}",
                line_content=""
            ))
    
    def validate_repository(self, repo_root: Path) -> None:
        """Validate all citations in the repository"""
        # Validate metadata files first
        self.validate_citation_metadata(repo_root)
        
        # Find all markdown files
        md_files = list(repo_root.rglob('*.md'))
        
        for md_file in md_files:
            # Skip hidden directories and files
            if any(part.startswith('.') for part in md_file.parts):
                continue
            self.validate_file(md_file)
    
    def generate_report(self) -> str:
        """Generate a validation report"""
        if not self.issues:
            return "✅ All citations validated successfully! No issues found.\n"
        
        report = f"📋 Citation Validation Report\n"
        report += f"{'='*50}\n\n"
        report += f"Found {len(self.issues)} issue(s):\n\n"
        
        # Group issues by type
        issues_by_type = {}
        for issue in self.issues:
            if issue.issue_type not in issues_by_type:
                issues_by_type[issue.issue_type] = []
            issues_by_type[issue.issue_type].append(issue)
        
        for issue_type, issues in issues_by_type.items():
            report += f"## {issue_type.replace('_', ' ').title()} ({len(issues)} issues)\n\n"
            for issue in issues:
                report += f"**File:** {issue.file_path}\n"
                if issue.line_number > 0:
                    report += f"**Line:** {issue.line_number}\n"
                report += f"**Issue:** {issue.message}\n"
                if issue.line_content:
                    report += f"**Content:** `{issue.line_content}`\n"
                report += "\n"
        
        return report


def main():
    """Main function to run citation validation"""
    repo_root = Path(__file__).parent.parent
    validator = CitationValidator()
    
    print("🔍 Validating institutional citations...")
    validator.validate_repository(repo_root)
    
    # Generate and print report
    report = validator.generate_report()
    print(report)
    
    # Save report to file
    report_file = repo_root / 'citation_validation_report.md'
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write(report)
    
    print(f"📄 Report saved to: {report_file}")
    
    # Exit with error code if issues found
    if validator.issues:
        exit(1)
    else:
        exit(0)


if __name__ == "__main__":
    main()