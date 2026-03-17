# 05 - Microsoft Sentinel: The Security Brain

## 🏛️ Deployment Strategy
Microsoft Sentinel was enabled on the centralized **Log Analytics Workspace** to transform raw telemetry into actionable security intelligence. By layering Sentinel over our Hub-and-Spoke logs, we gain a unified "single pane of glass" for threat detection, investigation, and response.

---

## 🛠️ Configuration Steps

### 1. Workspace Integration
I connected the `vnet-hub-security` workspace to Sentinel, ensuring that all security events (4624, 4625, etc.) streamed via the **Azure Monitor Agent (AMA)** were immediately available for analysis.

### 2. Data Connector Logic
To ensure a full-stack view of the attack surface, I activated the following connectors:
* **Azure Activity:** To monitor for unauthorized RBAC changes and resource manipulation.
* **Microsoft Defender for Cloud:** To pull in high-level infrastructure alerts.
* **Windows Security Events (via AMA):** For deep visibility into host-level authentication.

### 3. Analytics Rule Development
I configured custom **Analytics Rules** to monitor for the specific tactics used in the attack simulation. These rules use **Scheduled Query** logic to scan the logs every 5 minutes for suspicious patterns.
> *Note: I mapped each rule to the **MITRE ATT&CK Framework** to simplify the triage process for analysts.*

---

## 🚀 Sentinel Capabilities Demonstrated
In this lab, I utilized Sentinel’s core features to manage the incident lifecycle:

| Feature | Application in Lab |
| :--- | :--- |
| **Threat Intelligence** | Used to cross-reference source IPs with known malicious actors. |
| **Incident Management** | Grouped multiple alerts (Brute Force + Success) into a single high-priority incident. |
| **Investigation Graph** | Used to visualize the relationship between the attacker's IP, the Target VM, and the Key Vault. |
| **Entity Mapping** | Mapped accounts, hosts, and IPs to allow for faster searching across the environment. |

---

## 🔍 Sentinel Health Check
I validated the setup by ensuring the **Data Residency** and **Retention Policies** were aligned with the goal of preserving evidence for at least 30 days, ensuring enough history for forensic deep-dives.

Figure 8 — Microsoft Sentinel enabled on the Log Analytics workspace to provide SIEM capabilities.
---
*Next Step: View the [06-Attack Simulation](./06-attack-simulation.md) to see how we tested these Sentinel rules.*