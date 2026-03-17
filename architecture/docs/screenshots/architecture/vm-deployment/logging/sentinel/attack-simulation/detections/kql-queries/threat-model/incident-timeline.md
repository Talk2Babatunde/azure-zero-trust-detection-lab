# ⏱️ Incident Investigation Timeline

This timeline was reconstructed using the **Investigation-Timeline.kql** query across `SecurityEvent` and `AzureActivity` tables.

| Time (UTC) | Action | Source Entity | Event/Signal |
| :--- | :--- | :--- | :--- |
| **14:00** | Brute force attack initiated | Attacker IP (External) | 150x Event 4625 |
| **14:12** | Successful RDP login detected | `Admin-Babatunde` | Event ID 4624 |
| **14:15** | Pivot to Azure Portal | `Admin-Babatunde` | SigninLogs: Browser Access |
| **14:20** | Privilege Escalation attempted | Azure Resource Manager | `Create Role Assignment` |
| **14:25** | Key Vault Secret Retrieval | `kv-prod-secrets` | `SecretGet` triggered |
| **14:26** | **Sentinel Incident Generated** | **Analytical Rule 001** | Incident #482 triggered |

---
**Status:** Incident Resolved. 
**Root Cause:** Compromised credentials due to lack of MFA and overly permissive RBAC.