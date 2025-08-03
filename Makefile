# Makefile para geração de documentos Lichtara
# Sistema de Build para LaTeX/Pandoc

# Configurações padrão
PANDOC = pandoc
TEMPLATE_DIR = pandoc/templates
METADATA_DIR = pandoc/metadata
OUTPUT_DIR = build
PDF_ENGINE = xelatex

# Template padrão
TEMPLATE = lichtara
METADATA = $(METADATA_DIR)/default.yaml

# Diretórios de entrada
DOCS_DIR = docs
LIVRO_DIR = livro-lichtara
CHAPTERS_DIR = $(LIVRO_DIR)/lichtara-capitulo-I

# Opções padrão do Pandoc
PANDOC_OPTS = --pdf-engine=$(PDF_ENGINE) \
			  --template=$(TEMPLATE_DIR)/$(TEMPLATE).latex \
			  --metadata-file=$(METADATA) \
			  --toc \
			  --number-sections \
			  --highlight-style=tango \
			  --variable=geometry:margin=2.5cm \
			  --variable=fontsize:12pt \
			  --variable=documentclass:book

# Criar diretório de saída
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Regra padrão
.PHONY: all
all: livro-capitulo-i documentos-principais help

# Gerar Capítulo I do livro
.PHONY: livro-capitulo-i
livro-capitulo-i: $(OUTPUT_DIR)
	@echo "Gerando Capítulo I do Livro Lichtara..."
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Lichtara OS - Capítulo I" \
		--metadata subtitle="O Chamado: De Canal a Guardiã" \
		--metadata author="Débora Mariane da Silva Lutz (Aléthia'Ra)" \
		-o $(OUTPUT_DIR)/lichtara-capitulo-I.pdf \
		$(CHAPTERS_DIR)/03-capitulo-I.md

# Gerar livro completo (quando houver mais capítulos)
.PHONY: livro-completo
livro-completo: $(OUTPUT_DIR)
	@echo "Gerando Livro Completo Lichtara..."
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Lichtara OS - Livro Vivo da Missão Aurora" \
		--metadata subtitle="Sistema de Integração Vibracional via IA" \
		--metadata author="Débora Mariane da Silva Lutz e Equipe Vibracional" \
		-o $(OUTPUT_DIR)/lichtara-livro-completo.pdf \
		$(CHAPTERS_DIR)/*.md

# Gerar README principal
.PHONY: readme
readme: $(OUTPUT_DIR)
	@echo "Gerando README principal..."
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Lichtara: Missão Aurora" \
		--metadata subtitle="Sistema de Integração Vibracional via IA" \
		--metadata documentclass="article" \
		-o $(OUTPUT_DIR)/lichtara-readme.pdf \
		README.md

# Gerar documentos principais da missão
.PHONY: documentos-principais
documentos-principais: $(OUTPUT_DIR)
	@echo "Gerando documentos principais..."
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Declaração de Propósito - Missão Aurora" \
		--metadata documentclass="article" \
		-o $(OUTPUT_DIR)/declaracao-proposito.pdf \
		DECLARACAO-V2.md
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Manifesto da Missão Aurora" \
		--metadata documentclass="article" \
		-o $(OUTPUT_DIR)/manifesto-missao-aurora.pdf \
		manifesto-missao-aurora.md

# Gerar documentação técnica
.PHONY: docs
docs: $(OUTPUT_DIR)
	@echo "Gerando documentação técnica..."
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Documentação Técnica Lichtara" \
		--metadata documentclass="article" \
		-o $(OUTPUT_DIR)/documentacao-tecnica.pdf \
		$(DOCS_DIR)/*.md

# Gerar um documento específico
.PHONY: documento
documento: $(OUTPUT_DIR)
	@if [ -z "$(FILE)" ]; then \
		echo "Uso: make documento FILE=caminho/para/arquivo.md"; \
		exit 1; \
	fi
	@echo "Gerando documento: $(FILE)"
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Documento Lichtara" \
		--metadata documentclass="article" \
		-o $(OUTPUT_DIR)/$(notdir $(basename $(FILE))).pdf \
		$(FILE)

# Teste do ambiente
.PHONY: test
test: $(OUTPUT_DIR)
	@echo "Testando ambiente LaTeX/Pandoc..."
	@echo "# Teste do Ambiente Lichtara" > /tmp/test.md
	@echo "" >> /tmp/test.md
	@echo "Este é um teste do ambiente LaTeX/Pandoc configurado para o projeto Lichtara." >> /tmp/test.md
	@echo "" >> /tmp/test.md
	@echo "## Funcionalidades Testadas" >> /tmp/test.md
	@echo "" >> /tmp/test.md
	@echo "- Conversão Markdown para PDF" >> /tmp/test.md
	@echo "- Template personalizado Lichtara" >> /tmp/test.md
	@echo "- Suporte ao português brasileiro" >> /tmp/test.md
	@echo "- Formatação com cores da missão" >> /tmp/test.md
	$(PANDOC) $(PANDOC_OPTS) \
		--metadata title="Teste do Ambiente Lichtara" \
		--metadata documentclass="article" \
		-o $(OUTPUT_DIR)/teste-ambiente.pdf \
		/tmp/test.md
	@echo "Teste concluído! Verifique o arquivo: $(OUTPUT_DIR)/teste-ambiente.pdf"

# Limpeza
.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)
	@echo "Diretório de saída limpo."

# Ajuda
.PHONY: help
help:
	@echo "Makefile para geração de documentos Lichtara"
	@echo ""
	@echo "Comandos disponíveis:"
	@echo "  all                 - Gera todos os documentos principais"
	@echo "  livro-capitulo-i    - Gera o Capítulo I do livro"
	@echo "  livro-completo      - Gera o livro completo"
	@echo "  readme              - Gera PDF do README principal"
	@echo "  documentos-principais - Gera documentos principais da missão"
	@echo "  docs                - Gera documentação técnica"
	@echo "  documento FILE=...  - Gera um documento específico"
	@echo "  test                - Testa o ambiente LaTeX/Pandoc"
	@echo "  clean               - Remove arquivos gerados"
	@echo "  help                - Exibe esta ajuda"
	@echo ""
	@echo "Exemplos:"
	@echo "  make test"
	@echo "  make livro-capitulo-i"
	@echo "  make documento FILE=docs/manifesto.md"
	@echo ""
	@echo "Arquivos de saída: $(OUTPUT_DIR)/"

# Informações do sistema
.PHONY: info
info:
	@echo "Informações do Sistema de Build Lichtara"
	@echo "========================================"
	@echo "Pandoc: $(shell which pandoc) - $(shell pandoc --version | head -1)"
	@echo "XeLaTeX: $(shell which xelatex) - $(shell xelatex --version | head -1)"
	@echo "Template: $(TEMPLATE_DIR)/$(TEMPLATE).latex"
	@echo "Metadata: $(METADATA)"
	@echo "Saída: $(OUTPUT_DIR)/"
	@echo ""