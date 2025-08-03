# Scripts do Repositório Lichtara Research

Este diretório contém scripts para automatização e validação do repositório.

## Scripts Disponíveis

### validate_citations.py

**Descrição:** Script de validação de citações institucionais

**Uso:**
```bash
python scripts/validate_citations.py
```

**Funcionalidades:**
- Valida consistência de referências ao Professor Hélio Couto
- Verifica formatos de DOI, ORCID e emails institucionais
- Valida URLs e metadados de citação
- Gera relatórios detalhados de problemas encontrados

**Saída:**
- Relatório no console
- Arquivo `citation_validation_report.md` (ignorado pelo Git)
- Código de saída 0 para sucesso, 1 para problemas encontrados

**Dependências:**
- Python 3.7+
- PyYAML (ver requirements.txt)

## Instalação de Dependências

```bash
pip install -r scripts/requirements.txt
```

## Automação

Os scripts são executados automaticamente via GitHub Actions em:
- Push para branches principais
- Pull requests
- Execução manual

## Contribuições

Ao adicionar novos scripts:
1. Adicione documentação no README correspondente
2. Inclua dependências em requirements.txt
3. Torne o script executável: `chmod +x script.py`
4. Adicione testes se aplicável

Para mais detalhes sobre o sistema de validação de citações, consulte [docs/citation-validation-guide.md](../docs/citation-validation-guide.md).