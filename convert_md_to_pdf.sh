#!/bin/bash
# Script para converter todos os arquivos .md em PDFs usando pandoc

for file in $(find . -name '*.md'); do
    pdf_name="${file%.md}.pdf"
    pandoc "$file" -o "$pdf_name" --pdf-engine=xelatex --metadata title="Lichtara OS Manual" --variable mainfont="Arial" --variable fontsize=12pt
    echo "Convertido: $file -> $pdf_name"
done
