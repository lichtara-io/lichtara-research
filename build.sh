#!/bin/bash
# Script de build para documentos Lichtara
# Uso: ./build.sh [comando] [arquivo]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para logs
log() {
    echo -e "${GREEN}[Lichtara Build]${NC} $1"
}

error() {
    echo -e "${RED}[Erro]${NC} $1" >&2
}

warning() {
    echo -e "${YELLOW}[Aviso]${NC} $1"
}

info() {
    echo -e "${BLUE}[Info]${NC} $1"
}

# Verificar se as dependências estão instaladas
check_dependencies() {
    log "Verificando dependências..."
    
    if ! command -v pandoc &> /dev/null; then
        error "Pandoc não está instalado. Execute: sudo apt install pandoc"
        exit 1
    fi
    
    if ! command -v xelatex &> /dev/null; then
        error "XeLaTeX não está instalado. Execute: sudo apt install texlive-xetex"
        exit 1
    fi
    
    log "Dependências verificadas ✓"
}

# Função para exibir ajuda
show_help() {
    echo "Script de Build Lichtara - Sistema LaTeX/Pandoc"
    echo ""
    echo "Uso: $0 [comando] [opções]"
    echo ""
    echo "Comandos:"
    echo "  test                     - Testa o ambiente"
    echo "  livro                    - Gera o capítulo I do livro"
    echo "  readme                   - Gera PDF do README"
    echo "  documento <arquivo.md>   - Converte um arquivo específico"
    echo "  clean                    - Remove arquivos gerados"
    echo "  info                     - Mostra informações do sistema"
    echo "  help                     - Mostra esta ajuda"
    echo ""
    echo "Exemplos:"
    echo "  $0 test"
    echo "  $0 livro"
    echo "  $0 documento docs/manifesto.md"
    echo ""
}

# Função para teste do ambiente
test_environment() {
    log "Testando ambiente LaTeX/Pandoc..."
    
    mkdir -p build
    
    cat > /tmp/lichtara-test.md << 'EOF'
---
title: "Teste do Ambiente Lichtara"
subtitle: "Verificação do Sistema LaTeX/Pandoc"
author: "Sistema de Build Lichtara"
date: \today
documentclass: article
---

# Teste de Funcionamento

Este documento testa o ambiente LaTeX/Pandoc configurado para o projeto Lichtara.

## Funcionalidades Testadas

- **Conversão Markdown para PDF**: OK
- **Template personalizado**: OK  
- **Cores da missão**: OK
- **Suporte ao português**: OK
- **Formatação acadêmica**: OK

## Elementos de Formatação

### Listas

- Item 1
- Item 2
- Item 3

### Texto em Destaque

**Negrito** e *itálico* funcionando corretamente.

### Citação

> "Este repositório é uma semente viva de uma ciência do invisível em plena manifestação."  
> — Missão Aurora

### Código

```bash
make test
```

## Conclusão

Se você está lendo este PDF, o ambiente está funcionando corretamente!
EOF

    pandoc --defaults=pandoc/lichtara-defaults.yaml \
           --metadata title="Teste do Ambiente Lichtara" \
           --metadata subtitle="Verificação do Sistema LaTeX/Pandoc" \
           --metadata documentclass="article" \
           -o build/teste-ambiente.pdf \
           /tmp/lichtara-test.md
           
    if [ -f "build/teste-ambiente.pdf" ]; then
        log "Teste concluído com sucesso! ✓"
        info "Arquivo gerado: build/teste-ambiente.pdf"
    else
        error "Falha na geração do PDF de teste"
        exit 1
    fi
}

# Função para gerar livro
build_book() {
    log "Gerando Capítulo I do Livro Lichtara..."
    
    mkdir -p build
    
    if [ -f "livro-lichtara/lichtara-capitulo-I/03-capitulo-I.md" ]; then
        pandoc --defaults=pandoc/lichtara-defaults.yaml \
               --metadata title="Lichtara OS - Capítulo I" \
               --metadata subtitle="O Chamado: De Canal a Guardiã" \
               --metadata documentclass="book" \
               -o build/lichtara-capitulo-I.pdf \
               livro-lichtara/lichtara-capitulo-I/03-capitulo-I.md
        
        log "Capítulo I gerado: build/lichtara-capitulo-I.pdf"
    else
        warning "Arquivo do Capítulo I não encontrado, gerando com conteúdo disponível..."
        # Tentar outros arquivos
        if [ -f "livro-lichtara/lichtara-capitulo-I/01-livro-vivo-lichtara-vol1.md" ]; then
            pandoc --defaults=pandoc/lichtara-defaults.yaml \
                   --metadata title="Lichtara OS - Volume I" \
                   --metadata subtitle="Livro Vivo da Missão Aurora" \
                   --metadata documentclass="book" \
                   -o build/lichtara-volume-I.pdf \
                   livro-lichtara/lichtara-capitulo-I/01-livro-vivo-lichtara-vol1.md
            
            log "Volume I gerado: build/lichtara-volume-I.pdf"
        else
            error "Nenhum arquivo do livro encontrado"
            exit 1
        fi
    fi
}

# Função para gerar README
build_readme() {
    log "Gerando PDF do README..."
    
    mkdir -p build
    
    pandoc --defaults=pandoc/lichtara-defaults.yaml \
           --metadata title="Lichtara: Missão Aurora" \
           --metadata subtitle="Sistema de Integração Vibracional via IA" \
           --metadata documentclass="article" \
           -o build/lichtara-readme.pdf \
           README.md
           
    log "README gerado: build/lichtara-readme.pdf"
}

# Função para converter documento específico
build_document() {
    local input_file="$1"
    
    if [ -z "$input_file" ]; then
        error "Especifique o arquivo de entrada"
        echo "Uso: $0 documento <arquivo.md>"
        exit 1
    fi
    
    if [ ! -f "$input_file" ]; then
        error "Arquivo não encontrado: $input_file"
        exit 1
    fi
    
    log "Convertendo: $input_file"
    
    local output_name=$(basename "$input_file" .md)
    mkdir -p build
    
    pandoc --defaults=pandoc/lichtara-defaults.yaml \
           --metadata documentclass="article" \
           -o "build/${output_name}.pdf" \
           "$input_file"
           
    log "Documento gerado: build/${output_name}.pdf"
}

# Função para limpeza
clean_build() {
    log "Removendo arquivos gerados..."
    rm -rf build/
    log "Limpeza concluída"
}

# Função para mostrar informações
show_info() {
    echo "Informações do Sistema de Build Lichtara"
    echo "========================================"
    echo "Pandoc: $(pandoc --version | head -1)"
    echo "XeLaTeX: $(xelatex --version | head -1)"
    echo "Template: pandoc/templates/lichtara.latex"
    echo "Configuração: pandoc/lichtara-defaults.yaml"
    echo "Diretório de saída: build/"
    echo ""
}

# Programa principal
main() {
    check_dependencies
    
    case "${1:-help}" in
        test)
            test_environment
            ;;
        livro)
            build_book
            ;;
        readme)
            build_readme
            ;;
        documento)
            build_document "$2"
            ;;
        clean)
            clean_build
            ;;
        info)
            show_info
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            error "Comando desconhecido: $1"
            show_help
            exit 1
            ;;
    esac
}

# Executar programa principal
main "$@"