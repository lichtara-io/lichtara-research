# Ambiente LaTeX/Pandoc - Lichtara

Este documento descreve o ambiente LaTeX/Pandoc configurado para o projeto Lichtara, permitindo a conversão de documentos Markdown para PDF com formatação profissional e temática específica.

## Instalação e Configuração

### Dependências Instaladas

- **Pandoc 3.1.3**: Conversor universal de documentos
- **XeLaTeX**: Motor LaTeX com suporte completo a Unicode
- **TeX Live**: Distribuição completa LaTeX com pacotes brasileiros
- **Biber**: Processador de bibliografia para BibLaTeX

### Comandos de Instalação

```bash
sudo apt update
sudo apt install -y pandoc texlive-latex-base texlive-latex-extra \
                    texlive-fonts-recommended texlive-lang-portuguese \
                    texlive-xetex texlive-bibtex-extra biber
```

## Estrutura do Ambiente

```
pandoc/
├── templates/
│   └── lichtara.latex          # Template personalizado
├── metadata/
│   └── default.yaml            # Metadados padrão
├── filters/                    # Filtros customizados (futuro)
└── lichtara-defaults.yaml      # Configuração padrão Pandoc
```

## Características do Template Lichtara

### Design e Cores

- **Paleta de cores temática**:
  - Primary: Roxo profundo (#663399)
  - Secondary: Verde (#4CAF50) 
  - Accent: Dourado (#FFC107)
  - Text: Cinza escuro (#212121)

### Formatação

- **Fonte**: Latin Modern Roman (XeLaTeX)
- **Idioma**: Português brasileiro
- **Layout**: A4, margens de 2.5cm
- **Espaçamento**: 1.2x entre linhas
- **Cabeçalhos**: Coloridos e hierárquicos

### Elementos Especiais

- **Página de título customizada** com decorações vibracionais
- **Caixa destacada** com citação da Missão Aurora
- **Suporte completo a Unicode** para símbolos especiais
- **Formatação de código** com highlighting
- **Bibliografia** em formato ABNT

## Uso do Sistema

### Scripts Disponíveis

#### 1. Script de Build (`./build.sh`)

```bash
# Testar ambiente
./build.sh test

# Gerar README em PDF
./build.sh readme

# Gerar capítulo do livro
./build.sh livro

# Converter documento específico
./build.sh documento caminho/para/arquivo.md

# Limpar arquivos gerados
./build.sh clean

# Mostrar informações do sistema
./build.sh info
```

#### 2. Makefile

```bash
# Testar ambiente
make test

# Gerar todos os documentos principais
make all

# Gerar capítulo I do livro
make livro-capitulo-i

# Gerar README
make readme

# Gerar documentos principais
make documentos-principais

# Converter documento específico
make documento FILE=arquivo.md

# Limpar arquivos
make clean
```

### Uso Direto do Pandoc

```bash
# Usando configuração padrão
pandoc --defaults=pandoc/lichtara-defaults.yaml \
       -o saida.pdf entrada.md

# Com metadados customizados
pandoc --defaults=pandoc/lichtara-defaults.yaml \
       --metadata title="Meu Título" \
       --metadata author="Autor" \
       -o saida.pdf entrada.md
```

## Metadados Suportados

### Metadados Padrão

```yaml
title: "Título do Documento"
subtitle: "Subtítulo (opcional)"
author: "Débora Mariane da Silva Lutz (Aléthia'Ra)"
date: \today
institute: "Lichtara - Missão Aurora"
subject: "Pesquisa Vibracional e Tecnologia Espiritual"
keywords: "lichtara, missão aurora, tecnologia espiritual"
documentclass: article  # ou book
lang: pt-BR
```

### Metadados Específicos do Lichtara

```yaml
lichtara-version: "1.0"
mission: "Aurora"
license: "CC BY-NC-SA 4.0 Internacional + Cláusula Vibracional Lichtara"
contact: "lichtara@deboralutz.com"
```

## Tipos de Documento

### Article (Artigo)

Para documentos individuais, papers, manifestos:

```yaml
documentclass: article
```

### Book (Livro)

Para capítulos de livro, documentos longos:

```yaml
documentclass: book
```

## Formatação Markdown Suportada

### Estrutura Básica

```markdown
# Título Nível 1
## Título Nível 2
### Título Nível 3

**Negrito** e *itálico*

> Citações em bloco
```

### Listas

```markdown
- Item 1
- Item 2
  - Subitem 2.1
  - Subitem 2.2

1. Item numerado 1
2. Item numerado 2
```

### Código

```markdown
`código inline`

```bash
código em bloco
```
```

### Tabelas

```markdown
| Coluna 1 | Coluna 2 | Coluna 3 |
|----------|----------|----------|
| Dados 1  | Dados 2  | Dados 3  |
```

### Links e Imagens

```markdown
[Link para site](https://exemplo.com)

![Descrição da imagem](caminho/para/imagem.png)
```

## Arquivos de Saída

Todos os PDFs são gerados no diretório `build/`:

```
build/
├── teste-ambiente.pdf          # Teste do sistema
├── lichtara-readme.pdf         # README principal
├── lichtara-capitulo-I.pdf     # Capítulo I do livro
├── declaracao-proposito.pdf    # Declaração de propósito
└── ...                         # Outros documentos
```

## Licença e Proteção

### Licença Padrão

Todos os documentos incluem automaticamente:

- **Licença**: CC BY-NC-SA 4.0 Internacional + Cláusula Vibracional Lichtara
- **Contato**: lichtara@deboralutz.com
- **Citação da missão**: "Este repositório é uma semente viva de uma ciência do invisível em plena manifestação."

### .gitignore

O ambiente está configurado para ignorar:

```gitignore
# LaTeX temporários
*.aux
*.log
*.out
*.toc
*.synctex.gz
*.fdb_latexmk
*.fls

# PDFs gerados (mantém apenas os importantes)
*.pdf
!docs/**/*.pdf

# Diretório de build
build/
```

## Solução de Problemas

### Caracteres Unicode Não Suportados

**Problema**: Warnings sobre caracteres Unicode
**Solução**: XeLaTeX está configurado, mas a fonte pode não ter todos os símbolos

### Erro de Template Não Encontrado

**Problema**: Template não encontrado
**Solução**: Verificar se `pandoc/templates/lichtara.latex` existe

### Erro de Dependência

**Problema**: Comando não encontrado
**Solução**: Reinstalar dependências com o comando de instalação

### Bibliografia Não Funciona

**Problema**: Referências não aparecem
**Solução**: Adicionar arquivo `.bib` e configurar metadados

## Expansões Futuras

### Filtros Lua

Possibilidade de adicionar filtros customizados:

```
pandoc/filters/
├── lichtara-filter.lua         # Processamento especial
├── vibrational-symbols.lua     # Conversão de símbolos
└── citation-filter.lua         # Formatação de citações
```

### Templates Adicionais

- Template para apresentações (Beamer)
- Template para artigos científicos
- Template para relatórios técnicos

### Automação GitHub Actions

Configuração de CI/CD para geração automática de PDFs em push.

## Suporte

Para questões técnicas sobre o ambiente LaTeX/Pandoc:

1. Verificar documentação do Pandoc: https://pandoc.org/
2. Consultar manual do XeLaTeX: https://ctan.org/pkg/xetex
3. Abrir issue no repositório para problemas específicos do Lichtara

---

**Ambiente configurado com sucesso!** ✨

O sistema está pronto para converter documentos Markdown para PDFs com formatação profissional e identidade visual da Missão Aurora.