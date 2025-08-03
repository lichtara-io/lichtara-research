#!/bin/bash
# Script para converter todos os arquivos .md em PDFs usando pandoc

set -e  # Exit on any error

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Erro: pandoc não está instalado."
    echo "Instale com: sudo apt-get install pandoc texlive-xetex"
    exit 1
fi

# Check if xelatex is available
if ! command -v xelatex &> /dev/null; then
    echo "Aviso: xelatex não encontrado. Usando engine padrão."
    PDF_ENGINE=""
else
    PDF_ENGINE="--pdf-engine=xelatex"
fi

count=0
errors=0

# Convert markdown files to PDF
while IFS= read -r -d '' file; do
    pdf_name="${file%.md}.pdf"
    echo "Convertendo: $file -> $pdf_name"
    
    if pandoc "$file" -o "$pdf_name" $PDF_ENGINE \
        --metadata title="Lichtara OS Manual" \
        --variable mainfont="Arial" \
        --variable fontsize=12pt 2>/dev/null; then
        echo "✓ Sucesso: $pdf_name"
        ((count++))
    else
        echo "✗ Erro ao converter: $file"
        ((errors++))
    fi
done < <(find . -name '*.md' -print0)

echo ""
echo "Conversão finalizada:"
echo "- Arquivos convertidos: $count"
echo "- Erros: $errors"
