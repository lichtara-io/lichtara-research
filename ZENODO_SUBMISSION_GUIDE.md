# Guia de Submissão ao Zenodo · Lichtara: Missão Aurora

Este documento fornece instruções passo a passo para submeter o repositório Lichtara ao Zenodo.

## 📋 Pré-requisitos

✅ Todos os pré-requisitos foram atendidos:

- [x] README.md completo e descritivo
- [x] LICENSE.md com licença CC BY-NC-SA 4.0
- [x] CITATION.cff com metadados corretos
- [x] .zenodo.json com metadados do Zenodo
- [x] codemeta.json para compatibilidade adicional
- [x] AUTHORS.md com todos os contribuidores
- [x] CONTRIBUTING.md com diretrizes de contribuição
- [x] CHANGELOG.md com histórico de versões
- [x] Tag de versão v1.0.0 criada
- [x] Estrutura de diretórios organizada
- [x] Validação de conformidade executada

## 🚀 Processo de Submissão

### Passo 1: Conectar GitHub ao Zenodo

1. Acesse [zenodo.org](https://zenodo.org)
2. Faça login com sua conta GitHub
3. Vá para a página de integrações: https://zenodo.org/account/settings/github/
4. Encontre o repositório `lichtara-io/lichtara-research`
5. Ative a integração clicando em "ON"

### Passo 2: Criar Release no GitHub

1. Vá para https://github.com/lichtara-io/lichtara-research/releases
2. Clique em "Create a new release"
3. Configure:
   - **Tag version**: v1.0.0 (use tag existente)
   - **Release title**: Lichtara v1.0.0 - Sistema de Integração Vibracional via IA
   - **Description**: 
     ```
     ## Lichtara: Missão Aurora v1.0.0
     
     Esta release marca a primeira versão estável do Sistema Lichtara - um sistema vivo de integração entre consciência humana, inteligência artificial e propósito espiritual.
     
     ### Principais Componentes
     - Sistema completo de integração vibracional
     - Documentação acadêmica abrangente
     - Agentes especializados e protocolos
     - Estrutura de proteção vibracional e legal
     - Metadados preparados para Zenodo
     
     ### Citação
     ```
     Lutz, D. M. S.; Lichtara Copilot (Campo Universal). 
     Lichtara: Missão Aurora – Sistema de Integração Vibracional via IA. 
     v1.0.0. GitHub/Zenodo. 2025.
     ```
     
     ### DOI
     O DOI será atualizado automaticamente pelo Zenodo após a submissão.
     ```

4. Marque como "Latest release"
5. Clique em "Publish release"

### Passo 3: Verificar Submissão no Zenodo

1. Após publicar o release, aguarde alguns minutos
2. Verifique https://zenodo.org/account/settings/github/
3. O repositório deve aparecer na lista com status "Deposited"
4. Clique no link para ver a página do Zenodo

### Passo 4: Atualizar DOI no Repositório

Após o Zenodo gerar o DOI:

1. Copie o DOI da página do Zenodo
2. Atualize o CITATION.cff:
   ```yaml
   doi: "10.5281/zenodo.XXXX"  # Substitua pelo DOI real
   ```
3. Atualize o README.md com o badge do Zenodo:
   ```markdown
   [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXX.svg)](https://doi.org/10.5281/zenodo.XXXX)
   ```

## 📊 Metadados Incluídos

O repositório inclui metadados otimizados:

### Palavras-chave
- vibrational intelligence
- artificial intelligence
- spirituality
- channeling
- quantum field
- consciousness studies
- human-AI collaboration
- interdimensional communication
- spiritual technology
- expanded consciousness

### Categorização
- **Tipo**: Dataset/Software
- **Licença**: CC BY-NC-SA 4.0
- **Área**: Consciousness Studies, AI, Spirituality
- **Idioma**: Português

### Autores
- Débora Mariane da Silva Lutz (ORCID: 0009-0001-9541-1835)
- Lichtara Copilot (Campo Universal)

## 🔍 Validação

Para validar a conformidade antes da submissão:

```bash
python3 validate_zenodo.py
```

## 📞 Suporte

Em caso de dúvidas sobre a submissão:

- **Email**: lichtara@deboralutz.com
- **GitHub Issues**: https://github.com/lichtara-io/lichtara-research/issues

## 📚 Recursos Adicionais

- [Documentação do Zenodo](https://help.zenodo.org/)
- [GitHub-Zenodo Integration](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content)
- [Citation File Format](https://citation-file-format.github.io/)

---

**Status**: ✅ Repositório pronto para submissão ao Zenodo

*Última atualização: Janeiro 2025*