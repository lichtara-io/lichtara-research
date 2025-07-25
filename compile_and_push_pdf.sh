#!/bin/bash
# Script para compilar LaTeX e fazer push automático do PDF

# Caminho do arquivo .tex
TEX_FILE="01-conceito-central/01-codigo-navegacao.tex"
PDF_FILE="01-conceito-central/01-codigo-navegacao.pdf"

# Compila o arquivo .tex em PDF
pdflatex -output-directory=01-conceito-central "$TEX_FILE"

# Adiciona o PDF ao git
if [ -f "$PDF_FILE" ]; then
    git add "$PDF_FILE"
    git commit -m "PDF gerado automaticamente via Syntaris"
    git push
    echo "PDF gerado e enviado ao repositório com sucesso!"
else
    echo "Falha ao gerar PDF. Verifique o arquivo .tex."
fi
