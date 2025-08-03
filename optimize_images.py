#!/usr/bin/env python3
"""
Script to optimize images for better data loading performance.
Reduces file sizes while maintaining visual quality.
"""

import os
import subprocess
import sys
from pathlib import Path

def get_file_size(file_path):
    """Get file size in bytes."""
    return os.path.getsize(file_path)

def optimize_png(input_path, output_path=None):
    """Optimize PNG file using ImageMagick with gentle compression."""
    if output_path is None:
        output_path = input_path
    
    original_size = get_file_size(input_path)
    
    # Create a temporary file for optimization
    temp_path = str(input_path) + ".temp"
    
    try:
        # Use ImageMagick convert for safe compression
        # This reduces file size while maintaining quality
        subprocess.run([
            'convert', str(input_path),
            '-strip',  # Remove metadata
            '-quality', '85',  # High quality compression
            '-define', 'png:compression-level=9',  # Max PNG compression
            temp_path
        ], check=True, capture_output=True)
        
        # Check if optimization was successful and beneficial
        if os.path.exists(temp_path):
            new_size = get_file_size(temp_path)
            if new_size < original_size and new_size > 0:
                subprocess.run(['mv', temp_path, str(output_path)], check=True)
                reduction = ((original_size - new_size) / original_size) * 100
                print(f"✅ {input_path.name}: {original_size//1024}KB → {new_size//1024}KB (-{reduction:.1f}%)")
                return original_size - new_size
            else:
                # Remove temp file if no improvement
                os.remove(temp_path)
                print(f"⚠️  {input_path.name}: No improvement, keeping original")
                return 0
        else:
            print(f"❌ Failed to create optimized version of {input_path.name}")
            return 0
            
    except subprocess.CalledProcessError as e:
        # Clean up temp file if optimization failed
        if os.path.exists(temp_path):
            os.remove(temp_path)
        print(f"❌ Failed to optimize {input_path.name}: {e}")
        return 0

def main():
    """Main optimization function."""
    base_path = Path("/home/runner/work/lichtara-research/lichtara-research")
    images_path = base_path / "imagens"
    
    if not images_path.exists():
        print("❌ Images directory not found!")
        return
    
    # Find all PNG files
    png_files = list(images_path.rglob("*.png"))
    
    if not png_files:
        print("❌ No PNG files found!")
        return
    
    print(f"🔍 Found {len(png_files)} PNG files to optimize...")
    print("=" * 60)
    
    total_saved = 0
    processed = 0
    
    for png_file in png_files:
        if png_file.exists():
            saved = optimize_png(png_file)
            total_saved += saved
            processed += 1
    
    print("=" * 60)
    print(f"📊 Optimization Summary:")
    print(f"   Files processed: {processed}")
    print(f"   Total space saved: {total_saved // 1024}KB ({total_saved // (1024*1024)}MB)")
    print(f"   Average saving per file: {total_saved // max(processed, 1) // 1024}KB")

if __name__ == "__main__":
    main()