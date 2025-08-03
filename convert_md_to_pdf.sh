#!/bin/bash
# Optimized script to convert markdown files to PDFs with parallel processing and caching

# Configuration
MAX_PARALLEL=4
CACHE_DIR=".pdf_cache"
LOG_FILE="convert_pdf.log"

# Create cache directory
mkdir -p "$CACHE_DIR"

# Function to convert a single file
convert_file() {
    local md_file="$1"
    local pdf_name="${md_file%.md}.pdf"
    local cache_file="$CACHE_DIR/$(basename "$md_file").cache"
    
    # Check if file was already processed and source hasn't changed
    if [[ -f "$cache_file" && -f "$pdf_name" ]]; then
        local md_modified=$(stat -c %Y "$md_file" 2>/dev/null || echo 0)
        local cache_modified=$(stat -c %Y "$cache_file" 2>/dev/null || echo 0)
        
        if [[ $md_modified -le $cache_modified ]]; then
            echo "[CACHE] Skipped: $md_file (already up to date)" >> "$LOG_FILE"
            return 0
        fi
    fi
    
    # Convert the file
    echo "[START] Converting: $md_file" >> "$LOG_FILE"
    
    if pandoc "$md_file" -o "$pdf_name" \
        --pdf-engine=xelatex \
        --metadata title="Lichtara OS Manual" \
        --variable mainfont="Arial" \
        --variable fontsize=12pt \
        --variable geometry=margin=1in \
        2>>"$LOG_FILE"; then
        
        # Mark as cached on success
        touch "$cache_file"
        echo "[SUCCESS] Converted: $md_file -> $pdf_name" >> "$LOG_FILE"
        return 0
    else
        echo "[ERROR] Failed to convert: $md_file" >> "$LOG_FILE"
        return 1
    fi
}

# Export function for parallel execution
export -f convert_file
export CACHE_DIR LOG_FILE

# Start processing
echo "=== PDF Conversion Started at $(date) ===" > "$LOG_FILE"
echo "Converting markdown files to PDF with parallel processing (max $MAX_PARALLEL jobs)..."

# Find all markdown files and process them in parallel
find . -name '*.md' -print0 | \
    xargs -0 -n 1 -P "$MAX_PARALLEL" -I {} bash -c 'convert_file "$@"' _ {}

# Summary
total_files=$(find . -name '*.md' | wc -l)
successful_pdfs=$(find . -name '*.pdf' | wc -l)
cached_files=$(find "$CACHE_DIR" -name '*.cache' | wc -l)

echo "=== Conversion Summary ===" >> "$LOG_FILE"
echo "Total markdown files: $total_files" >> "$LOG_FILE"
echo "Successful PDFs: $successful_pdfs" >> "$LOG_FILE"
echo "Cached files: $cached_files" >> "$LOG_FILE"
echo "=== PDF Conversion Completed at $(date) ===" >> "$LOG_FILE"

echo "Conversion completed! Check $LOG_FILE for details."
echo "Total: $total_files markdown files, $successful_pdfs PDFs generated, $cached_files cached"
