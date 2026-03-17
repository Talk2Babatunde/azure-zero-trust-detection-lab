# 06 - Attack Simulation: The Adversary Playbook

## ⚔️ Simulation Strategy
To validate the detection pipeline, I executed a multi-stage attack simulation that mimics a persistent threat actor. The goal was to generate "dirty" telemetry across the network, identity, and resource layers to ensure our **Microsoft Sentinel** analytics rules were firing correctly.

---

## 🏗️ The Attack Lifecycle (MITRE ATT&CK Mapping)

### Stage 1: Initial Access (T1110.001 — Brute Force)
* **Action:** Executed a PowerShell script to generate 100+ failed RDP logon attempts against the `APP-SRV01` public IP.
* **Target:** `vnet-spoke-app` workload.
* **Expected Telemetry:** Windows Security Event ID **4625** (An account failed to log on).

### Stage 2: Persistence & Execution (T1078 — Valid Accounts)
* **Action:** Successfully authenticated using "guessed" credentials to simulate a breach of the perimeter.
* **Target:** Remote Interactive Session on `APP-SRV01`.
* **Expected Telemetry:** Windows Security Event ID **4624** (An account was successfully logged on).

### Stage 3: Privilege Escalation (T1098 — Account Manipulation)
* **Action:** Navigated to the Azure Portal/CLI and assigned the "Key Vault Secrets Officer" role to the compromised account to simulate an insider threat or escalated permissions.
* **Target:** Azure Entra ID (RBAC).
* **Expected Telemetry:** Azure Activity Log `Create Role Assignment`.

### Stage 4: Impact/Exfiltration (T1530 — Data from Cloud Storage)
* **Action:** Attempted to "Get" a production secret from the Azure Key Vault (`kv-prod-secrets`).
* **Target:** Azure Key Vault.
* **Expected Telemetry:** `VaultGet`, `SecretGet` operations in `AzureDiagnostics` logs.

---

## 🛠️ Tools Used
- **PowerShell:** For automating failed logon attempts and generating system noise.
- **Azure CLI:** For simulating resource-level manipulation and privilege escalation.
- **Manual Intervention:** To simulate human behavior patterns (e.g., browsing files, checking environment variables).

---

## 🧪 Validation Results
After the simulation was completed, I verified that:
1.  Logs were successfully streamed from the Spokes to the Hub via the **AMA**.
2.  The **KQL Analytics Rules** correlated these events into a single "High" severity incident in Sentinel.
3.  The **Investigation Graph** correctly mapped the attacker's path from the IP to the Key Vault.

Figure 9 — Multiple failed RDP authentication attempts generated during brute force simulation.

---
*Next Step: View the specific detection logic in [07-Detection Engineering](./07-detection-engineering.md).*