<div align="center">

<img src="https://raw.githubusercontent.com/Devopstrio/.github/main/assets/Browser_logo.png" height="85" alt="Devopstrio Logo" />

<h1>Enterprise AI Landing Zone (AI-LZ)</h1>

<p><strong>The Industrial Foundation for Generative AI, MLOps, and Intelligent Automation at Scale</strong></p>

[![Architecture](https://img.shields.io/badge/Architecture-Hub%E2%80%94Spoke-522c72?style=for-the-badge&labelColor=000000)](https://devopstrio.co.uk/)
[![Cloud](https://img.shields.io/badge/Platform-Azure_Enterprise-0078d4?style=for-the-badge&logo=microsoftazure&labelColor=000000)](/terraform)
[![Security](https://img.shields.io/badge/Security-Zero_Trust-962964?style=for-the-badge&labelColor=000000)](/terraform)
[![AI](https://img.shields.io/badge/AI-Generation_Next-success?style=for-the-badge&labelColor=000000)](https://devopstrio.co.uk/)

<br/>

> **"Scale your AI vision on a foundation of iron."** The AI Landing Zone (AI-LZ) is a production-hardened platform engineered to provide secure, governed, and self-service environments for enterprise AI workloads.

</div>

---

## 🏛️ Executive Summary

The **Enterprise AI Landing Zone (AI-LZ)** is a comprehensive deployment framework that automates the creation of high-security environments for AI, GenAI, and ML workloads. Built on **Azure Landing Zone (ALZ)** principles, it ensures that every AI project—from RAG platforms to model training—resides within a compliant, network-isolated, and governed ecosystem.

### Strategic Objectives
- **Accelerate Onboarding**: Transition from "Proposal" to "Provisioned AI Stack" in minutes.
- **Enforce Governance**: Automated Policy-as-Code to prevent public data exposure.
- **Enable FinOps**: Unit-cost visibility for GPU consumption and Token usage.
- **Scale Securely**: Standardized hub-spoke networking with regional failover.

---

## 🏗️ Technical Architecture

### 1. High-Level Blueprint
```mermaid
graph TD
    subgraph Management_Hierarchy
        MG[Enterprise Management Group]
        MG --> PLAT[Platform MG]
        MG --> WORK[Workload MG]
        PLAT --> HUB_SUB[Hub Subscription]
        WORK --> AI_SUB[AI Workload Subscriptions]
    end
    
    HUB_SUB --> HUB_VNET[Hub VNet: Firewall/DNS]
    AI_SUB --> SPOKE_VNET[Spoke VNet: AI Services]
    HUB_VNET <-->|Peering| SPOKE_VNET
```

### 2. Hub-Spoke Network Topology
```mermaid
graph LR
    subgraph Hub_VNet
        FW[Azure Firewall]
        DNS[Private DNS Resolver]
        GW[Application Gateway WAFv2]
    end
    
    subgraph AI_Workload_Spoke
        AKS[AKS with GPU Nodes]
        OAI[Azure OpenAI Service]
        COSMOS[(Cosmos DB)]
        PE[Private Endpoints]
    end
    
    SUBG[On-Premises] ---|ExpressRoute| FW
    FW --- PE
    GW --- AKS
```

### 3. AI Workload Request Flow
```mermaid
sequenceDiagram
    participant User as Engineering Team
    participant Portal as AI Self-Service Portal
    participant API as Provisioning Engine
    participant Cloud as Azure Resources
    
    User->>Portal: Request "GenAI RAG Workspace"
    Portal->>Portal: Validate Quota & Policy
    Portal->>API: Trigger Terraform Workflow
    API->>Cloud: Deploy Isolated Spoke VNet
    API->>Cloud: Provision Azure OpenAI + Key Vault
    API->>Cloud: Link Private DNS Zones
    Cloud-->>User: Delivery: "Secure Workspace Ready"
```

---

## 🛡️ Governance & Security Pillars

### Policy-as-Code Automation
- **`DENY-PUBLIC-AI-ENDPOINTS`**: Prevents creation of AI services with public access.
- **`REQUIRE-VNET-INJECTION`**: Enforces all AI compute to reside within a specific subnet.
- **`ENFORCE-MD-TAGGING`**: Mandatory tagging for cost allocation by Business Unit.

### Security Baseline Diagram
```mermaid
graph TD
    A[Internet] -->|WAF| B[App Gateway]
    B -->|Private Link| C[Internal AI API]
    C -->|Managed Identity| D[Key Vault]
    C -->|Private Link| E[(Vector Database)]
    F[Azure Defender] --- C
```

---

## 📦 Global Infrastructure Stack

| Layer | Component | Technology | Priority |
|:---|:---|:---|:---:|
| **Networking** | Hub-and-Spoke | Terraform / ExpressRoute | Critical |
| **Compute** | AKS (GPU) & Container Apps | K8s / Serverless | Performance |
| **AI Services** | Azure OpenAI / AI Studio | Cognitive Services | Core |
| **Identity** | Managed Identity / Entra ID | RBAC / PIM | Security |
| **Data** | ADLS Gen2 / Cosmos DB | Private Endpoint Storage | Foundation |

---

## 🚀 Self-Service Catalog

The AI-LZ includes a **Service Catalog** allowing teams to provision standardized "T-Shirt Sized" environments:

- **Small (GenAI Sandbox)**: Single OpenAI instance + Private Endpoint + Metadata DB.
- **Medium (RAG Platform)**: AKS Cluster + Vector Search (AI Search) + Private Storage.
- **Large (MLOps Pipeline)**: Full Hub-Spoke isolation + GPU Nodes + Databricks integration.

---

## 🗺️ Multi-Year Roadmap

- **Phase 1 (Now)**: Secure Hub-Spoke foundation & Azure OpenAI automation.
- **Phase 2 (Q3 2026)**: Integration of Multi-Region DR for LLM Inference.
- **Phase 3 (2027)**: "Autonomous Infrastructure"—AI-Ops-driven scaling and healing.

---

## 🆘 Support & Scaling
Devopstrio provides dedicated **Landing Zone Operations** to support global platform engineering teams.

- **Status**: [lz-status.devopstrio.co.uk](https://devopstrio.co.uk)
- **Email**: [lz-ops@devopstrio.co.uk](mailto:lz-ops@devopstrio.co.uk)

---
<sub>&copy; 2026 Devopstrio &mdash; Mastering the Enterprise AI Foundation.</sub>
