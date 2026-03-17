# 04 - Centralized Logging: The Foundation of Detection

## 🛡️ The Logging Philosophy
In a cloud environment, local logs are "volatile"—an attacker can clear them to hide their tracks. Centralized logging ensures that telemetry is streamed in real-time to a secure, immutable location (**Log Analytics Workspace**), preserving the evidence needed for an investigation.

## ⚙️ Technical Implementation: The AMA + DCR Model
I utilized the modern **Azure Monitor Agent (AMA)** and **Data Collection Rules (DCR)** to manage telemetry ingestion. This provides more granular control over which events are collected, reducing "noise" and saving on data ingestion costs.

Figure 7 — Data Collection Rule configuration used to deploy Azure Monitor Agent and collect security logs from all VMs.

### Ingestion Pipeline
1.  **Endpoints:** Windows/Linux VMs in Spoke networks.
2.  **Agent:** Azure Monitor Agent (AMA) installed on each workload.
3.  **Controller:** Data Collection Rules (DCR) define *which* logs to pull (e.g., Security Event IDs 4624, 4625, 4688).
4.  **Destination:** Centralized Log Analytics Workspace (LAW) in the Hub VNet.

---

## 📊 Telemetry Scope
The following logs were prioritized to ensure visibility into the simulated attack lifecycle:

| Log Source | Event Type | Purpose |
| :--- | :--- | :--- |
| **Security Events** | 4625 (Failed Logon) | Detect Brute-force attacks |
| **Security Events** | 4624 (Successful Logon) | Detect compromised account usage |
| **System Events** | Service Start/Stop | Detect persistence via service creation |
| **App Locker/Process** | 4688 (Process Creation) | Detect execution of malicious scripts/tools |
| **Key Vault Logs** | Secret Retrieval | Detect unauthorized data access |

---

## 🔍 Validation: "Is the Data Flowing?"
To ensure the "Visibility Gap" was closed, I used the following KQL query to heartbeat the agents:

```kusto
Heartbeat
| summarize LastHeartbeat = max(TimeGenerated) by Computer, OSType, _ResourceId
| order by LastHeartbeat desc


Figure 6 — Log Analytics Workspace acting as the central telemetry aggregation layer.