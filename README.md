<div align="center">

<img src="https://raw.githubusercontent.com/Devopstrio/.github/main/assets/Browser_logo.png" height="85" alt="Devopstrio Logo" />

<h1>AI Landing Zone (AI-LZ)</h1>

<p><strong>The Industrial Foundation for Generative AI, MLOps, and Intelligent Automation</strong></p>

[![Architecture](https://img.shields.io/badge/Architecture-Hub%E2%80%94Spoke-522c72?style=for-the-badge&labelColor=000000)](https://devopstrio.co.uk/)
[![Cloud](https://img.shields.io/badge/Cloud-Azure_ALZ-0078d4?style=for-the-badge&logo=microsoftazure&labelColor=000000)](/terraform)
[![Security](https://img.shields.io/badge/Compliance-SOC2_%7C_HIPAA-962964?style=for-the-badge&labelColor=000000)](/terraform)
[![AI](https://img.shields.io/badge/Status-Industrial_Grade-success?style=for-the-badge&labelColor=000000)](https://devopstrio.co.uk/)

<br/>

> **"Scale your AI vision on a foundation of iron."** The AI Landing Zone (AI-LZ) is a production-hardened platform designed to provide secure, governed, and self-service environments for enterprise AI workloads.

</div>

---

## 🏛️ High-Level Architecture (Reference)

![AI Landing Zone Architecture](assets/architecture.png)

---

## 📐 Enterprise Architecture Pillars

### 1. Management Group & Subscription Hierarchy
The AI-LZ follows the **Azure Landing Zone (ALZ)** conceptual architecture, utilizing a multi-subscription model to isolate platform services from AI workloads.

```mermaid
graph TD
    subgraph Enterprise_Root
        MG_R[Root Management Group]
        MG_R --> MG_P[Platform MG]
        MG_R --> MG_L[Landing Zones MG]
        
        MG_P --> S_HUB[Hub / Connectivity Subscription]
        MG_P --> S_MGMT[Management / Logging Subscription]
        MG_P --> S_SEC[Identity / Security Subscription]
        
        MG_L --> S_AI[AI Workload Subscriptions]
        MG_L --> S_DATA[Data Platform Subscriptions]
        MG_L --> S_SB[Sandbox Subscriptions]
    end
```

### 2. Hub-and-Spoke Networking Topology
A centralized Hub VNet manages egress via Azure Firewall, while Spoke VNets house isolated AI compute and data.

```mermaid
graph LR
    subgraph Hub_VNet
        FW[Azure Firewall]
        DNS[Private DNS Zones]
        GW[Application Gateway WAF]
    end
    
    subgraph AI_Spoke_VNet
        Sub1[Subnet: Compute AKS/GPU]
        Sub2[Subnet: Data PE/Cosmos]
        Sub3[Subnet: AI OpenAI]
    end
    
    FW <-->|Peering| Sub1
    GW <-->|Peering| Sub1
```

### 3. Self-Service Provisioning Workflow
Teams request resources via our **Governance Portal**, which triggers automated IaC deployments with built-in guardrails.

```mermaid
sequenceDiagram
    participant LT as Lead Scientist
    participant Portal as Self-Service Portal
    participant API as Provisioning Engine
    participant TF as Terraform Cloud
    participant Azure as Azure Environment

    LT->>Portal: Request "GenAI Workspace - Prod"
    Portal->>API: Validates Policy & Budget
    API->>TF: Initialize Workspace
    TF->>Azure: Provision Hub-Spoke VNet
    TF->>Azure: Provision Azure OpenAI + Private Link
    Azure-->>LT: Delivery: "Secure Environment URL"
```

---

## 🏗️ Technical Specification

| Domain | Solution Component | Tech Stack |
|:---|:---|:---|
| **Networking** | Hub-Spoke / Private Link | Terraform / Azure Firewall |
| **Compute** | AKS (GPU) & Container Apps | K8s / Azure Bicep |
| **AI Core** | Azure OpenAI / AI Studio | Cognitive Services |
| **Security** | Key Vault / Bastion / WAF | Managed Identity |
| **Governance** | Azure Policy / Purview | Policy-as-Code |
| **FinOps** | Budgeting & Tagging | Azure Cost Management |

---

## �️ Security & Compliance Baseline

The platform implements a **Zero-Trust** security model including:
- **NSG/ASG Hardening**: Strictly controlling East-West and North-South traffic.
- **Vulnerability Scanning**: Automated image scanning via Microsoft Defender.
- **Secret Management**: Zero-knowledge secret handling via Key Vault.
- **DDoS Protection**: Integrated Application Gateway with WAF protection for AI APIs.

---

## � Deployment Guide

### Local Provisioning
```powershell
./scripts/provision-ailz.ps1 -Environment prod
```

### CI/CD Trigger
The platform uses **GitHub Actions** for idempotent deployments.
1.  **Plan**: Automated IaC linting and cost estimation.
2.  **Approve**: Mandatory PR approval from Cloud Governance team.
3.  **Apply**: Deterministic deployment to the target subscription.

---

## 🆘 Support & Consulting
Devopstrio provides managed transition services for organizations migrating to industrial-grade AI foundations.

- **Web**: [devopstrio.co.uk](https://devopstrio.co.uk)
- **Consulting**: [ailz-support@devopstrio.co.uk](mailto:ailz-support@devopstrio.co.uk)

---
<sub>&copy; 2026 Devopstrio &mdash; Scaling AI Engineering Excellence.</sub>
