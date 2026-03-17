# Azure Zero-Trust Detection Lab: Engineering Detection for Multi-Stage Tenant Compromise

## 🛡️ Project Overview
This project simulates a real-world cloud compromise inside a Microsoft Azure tenant. It demonstrates how a **Zero-Trust architecture** combined with centralized telemetry and **Microsoft Sentinel** detection engineering can identify and correlate multi-stage attacker behavior.

The environment models an enterprise hub-and-spoke network architecture where multiple attack stages are simulated across segmented workloads to test the efficacy of modern security operations.

---

## 🏗️ Architecture & Technical Stack
| Category | Technology |
| :--- | :--- |
| **SIEM / SOAR** | Microsoft Sentinel |
| **Telemetry & Logging** | Log Analytics Workspace, Azure Monitor Agent (AMA), Sysmon |
| **Cloud Infrastructure** | Azure VNets (Hub-and-Spoke), Virtual Machines, Key Vault |
| **Identity & Access** | Entra ID (Azure AD), Role-Based Access Control (RBAC) |
| **Analysis Languages** | Kusto Query Language (KQL), PowerShell |

---

## ⚔️ Attacker Progression (The Attack Story)
This lab replicates a realistic adversary lifecycle based on the **MITRE ATT&CK** framework:

1.  **Initial Access:** RDP Brute-force attempts against a public-facing workload.
2.  **Execution:** Successful authentication and initial foothold on a Spoke VM.
3.  **Privilege Escalation:** Abuse of Azure role assignments to elevate permissions.
4.  **Exfiltration/Impact:** Unauthorized access to sensitive secrets in **Azure Key Vault**.
5.  **Detection:** Correlation of these events into a single high-fidelity incident in **Microsoft Sentinel**.

---

## 🎯 Core Objectives & Demonstrated Skills
- **Detection Engineering:** Developed custom KQL analytics rules to alert on failed/successful logins and RBAC changes.
- **Architecture Design:** Deployed a secure Hub-and-Spoke topology to practice network isolation and centralized logging.
- **Threat Simulation:** Executed PowerShell-based attack scripts to generate realistic security telemetry.
- **Incident Response:** Utilized Sentinel’s investigation graph to map the timeline of a compromise.
- **Zero Trust Implementation:** Applied the principle of "Least Privilege" and "Explicit Verification" across cloud resources.

---

## 📂 Documentation & Evidence
* [01-Project Overview](./docs/01-project-overview.md)
* [05-Sentinel Configuration](./docs/05-sentinel-setup.md)
* [07-Detection Engineering (KQL)](./docs/07-detection-engineering.md)
* [09-Lessons Learned & Visibility Gaps](./docs/09-lessons-learned.md)

---
*Developed by Babatunde Qodri – Cybersecurity Analyst focused on Adversary-Centric Detection.*