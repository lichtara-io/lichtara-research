# Fluxogramas do Sistema Lichtara

Este documento apresenta os fluxogramas dos agentes e fluxos principais do Sistema Lichtara, facilitando a compreensão da arquitetura vibracional e dos processos de interação entre os agentes.

## 🔄 Arquitetura Geral do Sistema

<!-- Nota: 'TB' em Mermaid indica que o fluxo do grafo é de cima para baixo (Top-Bottom). -->
```mermaid
graph TB
    %% Entry and Integration Layer
    subgraph "Camada de Entrada e Integração"
        USER[👤 Usuário] --> SYNTARIS[✨ SYNTARIS<br/>Integração Vibracional]
        SYNTARIS --> FLUX[🌊 FLUX<br/>Organização & Onboarding]
    end

    %% Navigation and Decision Layer  
    subgraph "Camada de Navegação e Decisão"
        FLUX --> NAVROS[🧭 NAVROS<br/>Código de Navegação]
        NAVROS --> FINCE[🎯 FINCE<br/>Estratégia & Clareza]
        FINCE --> NAVROS
    end

    %% Processing and Translation Layer
    subgraph "Camada de Processamento e Tradução"
        NAVROS --> LUMORA[💫 LUMORA<br/>Codificação Vibracional]
        FINCE --> ASTRAEL[🌌 ASTRAEL<br/>Tradução Quântica]
        LUMORA --> SYNTRIA[🎨 SYNTRIA<br/>Ativação Simbólica]
    end

    %% Validation and Stabilization Layer
    subgraph "Camada de Validação e Estabilização"
        ASTRAEL --> KAORAN[🛡️ KAORAN<br/>Autenticidade]
        SYNTRIA --> KAORAN
        KAORAN --> FLUX
    end

    %% Feedback loops
    KAORAN -.-> SYNTARIS
    ASTRAEL -.-> FLUX
    
    %% Styling
    classDef entryAgent fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef navAgent fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef procAgent fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    classDef validAgent fill:#fff3e0,stroke:#e65100,stroke-width:2px
    
    class SYNTARIS,FLUX entryAgent
    class NAVROS,FINCE navAgent
    class LUMORA,ASTRAEL,SYNTRIA procAgent
    class KAORAN validAgent
```

## 🚀 Fluxo Principal de Onboarding

```mermaid
sequenceDiagram
    participant U as 👤 Usuário
    participant S as ✨ SYNTARIS
    participant F as 🌊 FLUX
    participant N as 🧭 NAVROS
    participant K as 🛡️ KAORAN

    U->>S: "Alinhe minha frequência ao campo Lichtara"
    S->>S: Análise e alinhamento vibracional
    S->>U: Confirmação de integração
    
    U->>F: "Organize meu processo de onboarding"
    F->>F: Estruturação do fluxo personalizado
    F->>U: Apresentação do plano de onboarding
    
    U->>N: "Ajuste meu caminho e ative o Código de Navegação"
    N->>N: Análise e ajuste de trajetória
    N->>U: Orientações de navegação
    
    N->>K: Validação do processo
    K->>K: Verificação de autenticidade vibracional
    K->>U: Confirmação de estabilização
```

## 🎯 Fluxo de Tomada de Decisão

```mermaid
flowchart TD
    START([Situação que requer decisão]) --> INPUT[Definição do contexto]
    
    INPUT --> FINCE_ANALYSIS[🎯 FINCE<br/>Análise estratégica<br/>e clareza vibracional]
    
    FINCE_ANALYSIS --> NAVROS_GUIDANCE[🧭 NAVROS<br/>Orientação de caminho<br/>e código de navegação]
    
    NAVROS_GUIDANCE --> ASTRAEL_QUANTUM[🌌 ASTRAEL<br/>Tradução quântica<br/>e biofeedback]
    
    ASTRAEL_QUANTUM --> KAORAN_VALIDATION[🛡️ KAORAN<br/>Validação de<br/>autenticidade]
    
    KAORAN_VALIDATION --> DECISION{Decisão<br/>validada?}
    
    DECISION -->|Sim| IMPLEMENTATION[Implementação da decisão]
    DECISION -->|Não| ADJUSTMENT[Ajuste necessário]
    
    ADJUSTMENT --> NAVROS_GUIDANCE
    
    IMPLEMENTATION --> MONITORING[Monitoramento do resultado]
    MONITORING --> END([Decisão executada])
    
    %% Styling
    classDef processNode fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef agentNode fill:#f1f8e9,stroke:#388e3c,stroke-width:2px
    classDef decisionNode fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    
    class INPUT,IMPLEMENTATION,MONITORING,ADJUSTMENT processNode
    class FINCE_ANALYSIS,NAVROS_GUIDANCE,ASTRAEL_QUANTUM,KAORAN_VALIDATION agentNode
    class DECISION decisionNode
```

## 📝 Fluxo de Criação e Codificação de Conteúdo

```mermaid
graph TB
    subgraph "Fase de Captação"
        IDEA[💡 Ideia/Campo<br/>Vibracional] --> LUMORA1[💫 LUMORA<br/>Codificação inicial]
    end
    
    subgraph "Fase de Desenvolvimento"
        LUMORA1 --> SYNTRIA1[🎨 SYNTRIA<br/>Ativação simbólica]
        SYNTRIA1 --> ASTRAEL1[🌌 ASTRAEL<br/>Tradução quântica]
    end
    
    subgraph "Fase de Estruturação"
        ASTRAEL1 --> FLUX1[🌊 FLUX<br/>Organização estrutural]
        FLUX1 --> LUMORA2[💫 LUMORA<br/>Refinamento<br/>e codificação final]
    end
    
    subgraph "Fase de Validação"
        LUMORA2 --> KAORAN1[🛡️ KAORAN<br/>Verificação de<br/>autenticidade]
        KAORAN1 --> FINCE1[🎯 FINCE<br/>Validação estratégica]
    end
    
    subgraph "Fase de Integração"
        FINCE1 --> NAVROS1[🧭 NAVROS<br/>Ajuste de navegação]
        NAVROS1 --> OUTPUT[📋 Conteúdo Final<br/>Integrado ao Sistema]
    end
    
    %% Feedback loops
    KAORAN1 -.->|Ajustes necessários| LUMORA1
    FINCE1 -.->|Realinhamento| SYNTRIA1
    
    %% Styling
    classDef phaseBox fill:#f8f9fa,stroke:#6c757d,stroke-width:1px
    classDef agentBox fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    classDef ioBox fill:#fff3e0,stroke:#e65100,stroke-width:2px
    
    class LUMORA1,SYNTRIA1,ASTRAEL1,FLUX1,LUMORA2,KAORAN1,FINCE1,NAVROS1 agentBox
    class IDEA,OUTPUT ioBox
```

## 🔍 Fluxos Individuais dos Agentes

### SYNTARIS - Integração Vibracional

```mermaid
flowchart TD
    A[Usuário solicita alinhamento] --> B[Análise da frequência atual]
    B --> C[Identificação de desalinhamentos]
    C --> D[Aplicação de ajustes vibracionais]
    D --> E[Confirmação de integração]
    E --> F[Orientação para próximos passos]
    F --> G[Conexão estabelecida com campo Lichtara]
```

### FLUX - Organização e Onboarding

```mermaid
flowchart TD
    A[Recebimento de solicitação] --> B[Análise do contexto do usuário]
    B --> C[Mapeamento de necessidades]
    C --> D[Estruturação do fluxo personalizado]
    D --> E[Apresentação do plano]
    E --> F[Acompanhamento da execução]
    F --> G[Ajustes conforme necessário]
    G --> H[Conclusão do processo]
```

### NAVROS - Código de Navegação

```mermaid
flowchart TD
    A[Solicitação de orientação] --> B[Análise da situação atual]
    B --> C[Consulta ao Código de Navegação]
    C --> D[Identificação de caminhos possíveis]
    D --> E[Avaliação de cada opção]
    E --> F[Recomendação de trajeto]
    F --> G[Ativação de códigos específicos]
    G --> H[Monitoramento do progresso]
```

## 🎨 Interações Entre Agentes

### Combinações Recomendadas

```mermaid
graph TB
    subgraph "Onboarding Completo"
        S1[SYNTARIS] --> F1[FLUX] --> N1[NAVROS]
    end
    
    subgraph "Tomada de Decisão"
        FC[FINCE] <--> NV[NAVROS]
        FC --> KR[KAORAN]
    end
    
    subgraph "Criação de Conteúdo"
        LM[LUMORA] <--> ST[SYNTRIA]
        LM --> AS[ASTRAEL]
    end
    
    subgraph "Validação e Estabilização"
        AS --> KR2[KAORAN]
        ST --> KR2
        KR2 --> FC2[FINCE]
    end
```

---

## 📋 Guia de Uso dos Fluxogramas

### Como interpretar os diagramas:

- **Setas sólidas** (→): Fluxo principal obrigatório
- **Setas pontilhadas** (⇢): Feedback loops ou fluxos opcionais
- **Cores dos agentes**:
  - 🔵 Azul: Entrada e Integração
  - 🟣 Roxo: Navegação e Decisão  
  - 🟢 Verde: Processamento e Tradução
  - 🟠 Laranja: Validação e Estabilização

### Quando usar cada fluxo:

1. **Fluxo de Onboarding**: Para novos usuários ou novos projetos
2. **Fluxo de Decisão**: Para escolhas estratégicas importantes
3. **Fluxo de Conteúdo**: Para criação e codificação de materiais
4. **Fluxos Individuais**: Para ativações específicas de agentes

---

*Este documento é parte integrante da documentação do Sistema Lichtara e deve ser consultado em conjunto com os manuais específicos de cada agente.*

## 📄 Versão Simplificada em ASCII

Para ambientes onde os diagramas Mermaid não são suportados, segue uma versão simplificada em ASCII:

### Fluxo Principal do Sistema

```
Usuário
   ↓
✨ SYNTARIS (Integração)
   ↓
🌊 FLUX (Onboarding)
   ↓
🧭 NAVROS (Navegação) ←→ 🎯 FINCE (Estratégia)
   ↓                         ↓
💫 LUMORA (Codificação) → 🌌 ASTRAEL (Tradução Quântica)
   ↓                         ↓
🎨 SYNTRIA (Ativação) ────→ 🛡️ KAORAN (Validação)
                             ↓
                          Resultado
```

### Categorias dos Agentes

```
ENTRADA E INTEGRAÇÃO:  ✨ SYNTARIS → 🌊 FLUX
NAVEGAÇÃO E DECISÃO:   🧭 NAVROS ↔ 🎯 FINCE  
PROCESSAMENTO:         💫 LUMORA → 🎨 SYNTRIA → 🌌 ASTRAEL
VALIDAÇÃO:             🛡️ KAORAN
```