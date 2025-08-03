# Gerenciamento de Credenciais e Tokens - Lichtara Research

Este documento estabelece as diretrizes para o gerenciamento seguro de credenciais, tokens e variáveis de ambiente no projeto Lichtara Research.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Estrutura de Arquivos](#estrutura-de-arquivos)
- [Configuração Inicial](#configuração-inicial)
- [Ambientes de Desenvolvimento](#ambientes-de-desenvolvimento)
- [Segurança e Boas Práticas](#segurança-e-boas-práticas)
- [APIs e Serviços Externos](#apis-e-serviços-externos)
- [Resolução de Problemas](#resolução-de-problemas)

## 🎯 Visão Geral

O projeto Lichtara Research integra várias tecnologias e serviços externos mencionados na documentação técnica, incluindo:

- **OpenAI**: Para modelos de linguagem e assistentes
- **GitHub**: Para controle de versão e automações
- **Google Services**: Para integrações diversas
- **Microsoft**: Para serviços corporativos
- **NotebookLM/Notion**: Para gestão de conhecimento

Este sistema de gerenciamento de credenciais garante que todas as chaves e tokens sejam mantidos seguros e organizados.

## 📁 Estrutura de Arquivos

```
lichtara-research/
├── .env.example          # Template com todas as variáveis
├── .env                  # Arquivo local (nunca commitado)
├── .env.development      # Configurações de desenvolvimento
├── .env.staging          # Configurações de staging
├── .env.production       # Configurações de produção
├── .gitignore           # Exclui arquivos .env do git
└── docs/
    └── CREDENTIAL_MANAGEMENT.md  # Este documento
```

## 🚀 Configuração Inicial

### 1. Primeiro Setup

```bash
# Clone o repositório
git clone https://github.com/lichtara-io/lichtara-research.git
cd lichtara-research

# Copie o template
cp .env.example .env

# Edite o arquivo .env com suas credenciais
nano .env  # ou use seu editor preferido
```

### 2. Verificação de Segurança

```bash
# Verifique se os arquivos .env estão no .gitignore
grep -E "^\.env" .gitignore

# Confirme que nenhum arquivo .env será commitado
git status --ignored
```

### 3. Validação das Variáveis

```bash
# Para projetos Node.js, você pode usar:
node -e "require('dotenv').config(); console.log('✅ Arquivo .env carregado com sucesso');"
```

## 🌍 Ambientes de Desenvolvimento

### Ambiente Local (.env)
- Usado para desenvolvimento local
- Contém credenciais de teste/desenvolvimento
- Nunca deve ser commitado

### Ambiente de Staging (.env.staging)
- Usado para testes em ambiente similar à produção
- Credenciais de teste com dados não-críticos
- Pode ser commitado com valores dummy

### Ambiente de Produção (.env.production)
- Usado apenas em produção
- Contém credenciais reais e críticas
- Gerenciado através de variáveis de ambiente do servidor

## 🔒 Segurança e Boas Práticas

### ✅ O que FAZER

1. **Sempre use arquivos .env para credenciais locais**
   ```bash
   # ✅ Correto
   OPENAI_API_KEY=sk-proj-abc123...
   ```

2. **Use nomes descritivos para variáveis**
   ```bash
   # ✅ Correto
   OPENAI_API_KEY=sk-proj-abc123...
   GITHUB_TOKEN=ghp_abc123...
   
   # ❌ Evite
   KEY1=sk-proj-abc123...
   TOKEN=ghp_abc123...
   ```

3. **Agrupe variáveis por categoria**
   ```bash
   # ✅ OpenAI Configuration
   OPENAI_API_KEY=sk-proj-abc123...
   OPENAI_ORG_ID=org-abc123...
   
   # ✅ GitHub Configuration
   GITHUB_TOKEN=ghp_abc123...
   GITHUB_ORG=lichtara-io
   ```

4. **Documente cada variável no .env.example**
   ```bash
   # OpenAI API key para modelos de linguagem
   OPENAI_API_KEY=sk-your-openai-api-key-here
   ```

5. **Use ferramentas de validação**
   ```bash
   # Instale uma ferramenta para validar .env
   npm install --save-dev dotenv-safe
   ```

### ❌ O que NÃO fazer

1. **NUNCA commite arquivos .env reais**
   ```bash
   # ❌ NUNCA faça isso
   git add .env
   git commit -m "Added environment variables"
   ```

2. **NUNCA coloque credenciais em código**
   ```javascript
   // ❌ NUNCA faça isso
   const apiKey = 'sk-proj-abc123...';
   
   // ✅ Faça isso
   const apiKey = process.env.OPENAI_API_KEY;
   ```

3. **NUNCA use credenciais de produção em desenvolvimento**
   ```bash
   # ❌ Evite usar em .env local
   OPENAI_API_KEY=sk-proj-production-key...
   
   # ✅ Use credenciais de teste
   OPENAI_API_KEY=sk-proj-test-key...
   ```

## 🔌 APIs e Serviços Externos

### OpenAI (Mencionado na documentação)

```bash
# Configuração básica
OPENAI_API_KEY=sk-proj-your-key-here
OPENAI_ORG_ID=org-your-org-here

# Configurações avançadas
OPENAI_MODEL=gpt-4-turbo
OPENAI_MAX_TOKENS=4000
OPENAI_TEMPERATURE=0.7
```

**Como obter:**
1. Acesse [platform.openai.com](https://platform.openai.com)
2. Vá em "API Keys"
3. Clique em "Create new secret key"
4. Copie a chave e adicione ao seu .env

### GitHub API

```bash
# Token para acessar repositórios
GITHUB_TOKEN=ghp_your-token-here
GITHUB_ORG=lichtara-io
```

**Como obter:**
1. Vá em GitHub Settings > Developer settings > Personal access tokens
2. Clique em "Generate new token (classic)"
3. Selecione os escopos necessários
4. Copie o token e adicione ao .env

### Google Services

```bash
# Para Google APIs
GOOGLE_API_KEY=your-google-api-key
GOOGLE_APPLICATION_CREDENTIALS=path/to/service-account.json
```

### Microsoft Services

```bash
# Para Microsoft Graph API
MICROSOFT_CLIENT_ID=your-client-id
MICROSOFT_CLIENT_SECRET=your-client-secret
MICROSOFT_TENANT_ID=your-tenant-id
```

## 🛠️ Resolução de Problemas

### Problema: Arquivo .env não está sendo carregado

**Solução:**
```bash
# Verifique se o arquivo existe
ls -la | grep .env

# Verifique o formato do arquivo
cat .env | head -5

# Para Node.js, certifique-se de carregar no início
require('dotenv').config();
```

### Problema: Credenciais inválidas

**Solução:**
1. Verifique se a chave não possui espaços extras
2. Confirme se a chave não expirou
3. Teste a chave diretamente na API

```bash
# Teste OpenAI API
curl -H "Authorization: Bearer $OPENAI_API_KEY" \
     -H "Content-Type: application/json" \
     https://api.openai.com/v1/models
```

### Problema: Variável não encontrada

**Solução:**
```bash
# Verifique se a variável está definida
echo $OPENAI_API_KEY

# Para Node.js
node -e "console.log(process.env.OPENAI_API_KEY)"
```

## 📚 Recursos Adicionais

### Ferramentas Recomendadas

1. **dotenv**: Para carregar variáveis de ambiente
   ```bash
   npm install dotenv
   ```

2. **dotenv-safe**: Para validação de variáveis obrigatórias
   ```bash
   npm install dotenv-safe
   ```

3. **envalid**: Para validação e parsing de variáveis
   ```bash
   npm install envalid
   ```

### Scripts Úteis

```json
{
  "scripts": {
    "env:check": "node -e \"require('dotenv').config(); console.log('✅ Environment loaded');\"",
    "env:validate": "node scripts/validate-env.js",
    "env:example": "cp .env.example .env"
  }
}
```

### Exemplo de Script de Validação

```javascript
// scripts/validate-env.js
require('dotenv').config();

const requiredVars = [
  'OPENAI_API_KEY',
  'GITHUB_TOKEN',
  'NODE_ENV'
];

const missing = requiredVars.filter(key => !process.env[key]);

if (missing.length > 0) {
  console.error('❌ Missing required environment variables:');
  missing.forEach(key => console.error(`   - ${key}`));
  process.exit(1);
}

console.log('✅ All required environment variables are set');
```

## 🔄 Atualizações e Manutenção

### Rotina de Manutenção

1. **Revisão Mensal**
   - Verifique chaves que podem expirar
   - Atualize credenciais de teste
   - Remova variáveis não utilizadas

2. **Auditoria de Segurança**
   - Confirme que nenhuma credencial foi commitada
   - Verifique logs de acesso às APIs
   - Atualize senhas regularmente

3. **Documentação**
   - Mantenha o .env.example atualizado
   - Documente novas variáveis
   - Atualize este guia conforme necessário

---

## 📞 Suporte

Para dúvidas sobre gerenciamento de credenciais:

- Abra uma issue no repositório
- Consulte a documentação das APIs específicas
- Verifique os logs de erro da aplicação

**Importante**: Nunca compartilhe credenciais reais em issues, discussões ou documentação pública.