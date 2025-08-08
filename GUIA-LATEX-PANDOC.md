# Guia Rápido - LaTeX/Pandoc Lichtara

## Comandos Essenciais

### Testar o Ambiente
```bash
./build.sh test
make test
```

### Gerar PDFs Principais
```bash
# README do projeto
./build.sh readme

# Capítulo I do livro
./build.sh livro

# Documento específico
./build.sh documento caminho/arquivo.md
```

### Limpeza
```bash
./build.sh clean
make clean
```

## Template Básico Markdown

```markdown
---
title: "Título do Documento"
subtitle: "Subtítulo (opcional)"
author: "Seu Nome"
documentclass: article
---

# Introdução

Seu conteúdo aqui...

## Seção

- Lista item 1
- Lista item 2

### Subseção

**Negrito** e *itálico*

> Citação importante

```bash
código de exemplo
```

## Conclusão

Texto final.
```

## Diretórios Importantes

- `pandoc/templates/` - Templates LaTeX
- `pandoc/metadata/` - Metadados padrão
- `build/` - PDFs gerados

## Cores Lichtara

- Primary: `#663399` (roxo)
- Secondary: `#4CAF50` (verde)
- Accent: `#FFC107` (dourado)

## Suporte

Para problemas, verifique:
1. Dependências instaladas: `./build.sh info`
2. Arquivos de template existem
3. Sintaxe Markdown correta