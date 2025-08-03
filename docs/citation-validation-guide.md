# Citation Validation System

Este documento descreve o sistema de validação de citações institucionais implementado no repositório Lichtara Research.

## Visão Geral

O sistema de validação foi criado para garantir consistência e precisão nas citações e referências institucionais ao longo de todo o repositório. Ele valida:

- Formatos corretos de DOI (especialmente o Zenodo DOI do projeto)
- Consistência nas referências ao Professor Hélio Couto Couto
- Formatos corretos de ORCID
- Emails institucionais padronizados
- URLs bem formadas
- Metadados de citação (CITATION.cff e codemeta.json)

## Como Usar

### Execução Manual

Para executar a validação manualmente:

```bash
# A partir do diretório raiz do repositório
python scripts/validate_citations.py
```

### Dependências

Instale as dependências necessárias:

```bash
pip install -r scripts/requirements.txt
```

### Validação Automática

O sistema roda automaticamente via GitHub Actions em:
- Push para as branches `main` e `develop`
- Pull requests para `main`
- Execução manual via workflow dispatch

## Padrões de Citação

### Professor Hélio Couto Couto
**Formato padrão:** `Professor Hélio Couto Couto`

**Variações aceitáveis:**
- `Professor Hélio Couto`
- `Hélio Couto`
- `Professor Hélio Couto Couto` (em contextos menos formais)

### DOI Zenodo
**Formato padrão:** 10.5281/zenodo.16196582

### ORCID
**Formato padrão:** `0009-0001-9541-1835`

### Email Institucional
**Formato padrão:** `contact@lichtara.io`

## Tipos de Validação

### 1. Consistência de Referências Institucionais
- Verifica se as referências ao Professor Hélio Couto Couto seguem o formato padronizado
- Identifica variações inconsistentes que podem precisar de correção

### 2. Validação de Metadados
- Verifica a estrutura e conteúdo dos arquivos `CITATION.cff` e `codemeta.json`
- Confirma a presença de campos obrigatórios
- Valida formatos de DOI e ORCID nos metadados

### 3. Validação de URLs
- Identifica URLs potencialmente malformadas
- Detecta problemas comuns como pontuação extra no final das URLs

### 4. Validação de Emails
- Verifica consistência dos emails institucionais
- Garante que emails relacionados ao Lichtara sigam o padrão estabelecido

## Relatórios de Validação

O script gera um relatório em markdown (`citation_validation_report.md`) que inclui:

- Resumo dos problemas encontrados
- Localização específica (arquivo e linha) de cada problema
- Descrição detalhada do problema
- Conteúdo da linha problemática

### Exemplo de Relatório

```markdown
## Inconsistent Helio Reference (1 issues)

**File:** /caminho/para/arquivo.md
**Line:** 24
**Issue:** Inconsistent Professor Hélio Couto reference. Found: 'Professor Hélio Couto', Expected: 'Professor Hélio Couto Couto'
**Content:** `Em outubro de 2024, decidi mudar caminhos profissionais e abrir mão do que não cabia mais, em busca de minha missão. Lembro do exercício do Professor Hélio Couto Couto...`
```

## Correção de Problemas

### Problemas Comuns e Soluções

1. **Referência inconsistente ao Professor Hélio Couto**
   - **Problema:** `Professor Hélio Couto` em vez de `Professor Hélio Couto Couto`
   - **Solução:** Padronizar para `Professor Hélio Couto Couto` em contextos formais

2. **URLs malformadas**
   - **Problema:** URLs terminando com pontuação `https://exemplo.com`
   - **Solução:** Remover pontuação extra `https://exemplo.com`

3. **DOI inconsistente**
   - **Problema:** DOI com pontuação extra 10.5281/zenodo.16196582
   - **Solução:** Usar formato limpo 10.5281/zenodo.16196582

4. **Email institucional inconsistente**
   - **Problema:** `contact@lichtara.io` em vez de `contact@lichtara.io`
   - **Solução:** Atualizar para o email institucional padrão

## Configuração Avançada

### Modificando Padrões

Para modificar os padrões de validação, edite a classe `CitationValidator` em `scripts/validate_citations.py`:

```python
self.standard_formats = {
    'professor_helio': 'Professor Hélio Couto Couto',
    'orcid_format': '0009-0001-9541-1835',
    'zenodo_doi': '10.5281/zenodo.16196582
    'email_contact': 'contact@lichtara.io'
}
```

### Adicionando Novos Tipos de Validação

Para adicionar novas validações, implemente métodos na classe `CitationValidator` seguindo o padrão:

```python
def _check_nova_validacao(self, file_path: Path, line_num: int, line: str) -> None:
    """Check for nova validação"""
    # Lógica de validação
    if problema_encontrado:
        self.issues.append(CitationIssue(
            file_path=str(file_path),
            line_number=line_num,
            issue_type="novo_tipo_problema",
            message=f"Descrição do problema: {detalhes}",
            line_content=line.strip()
        ))
```

## Integração com Workflow

O sistema está integrado ao workflow de CI/CD e:
- Bloqueia merges se houver problemas críticos de citação
- Gera comentários automáticos em Pull Requests com resultados da validação
- Salva relatórios como artefatos para análise posterior

## Manutenção

### Atualizações Regulares

1. Revisar relatórios de validação regularmente
2. Atualizar padrões conforme necessário
3. Corrigir problemas identificados
4. Manter documentação atualizada

### Monitoramento

- Acompanhar execuções via GitHub Actions
- Revisar artefatos gerados
- Analisar tendências nos tipos de problemas encontrados

Este sistema garante que todas as citações institucionais no repositório mantenham alta qualidade e consistência, contribuindo para a integridade acadêmica e profissional do projeto Lichtara.