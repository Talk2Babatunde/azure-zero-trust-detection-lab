# 📑 MITRE ATT&CK Framework Mapping

I have mapped the simulated attack lifecycle to the following MITRE ATT&CK tactics and techniques to ensure detection coverage.

| Attack Stage | Tactic | Technique | MITRE ID | Detection Logic |
| :--- | :--- | :--- | :--- | :--- |
| **Stage 1** | Initial Access | Brute Force: Password Cracking | **T1110.001** | KQL: Event ID 4625 bursts |
| **Stage 2** | Persistence | Valid Accounts | **T1078.004** | KQL: Event ID 4624 from new IP |
| **Stage 3** | Privilege Escalation | Account Manipulation | **T1098** | AzureActivity: Role Assignment write |
| **Stage 4** | Credential Access | Steal or Forge Kerberos Tickets | **T1558** | KeyVault: SecretGet / SecretList |
| **Stage 5** | Exfiltration | Transfer Data to Cloud Account | **T1537** | Sentinel: Identity correlation |

### 🛠️ Defensive Matrix
- **Prevent:** NSG hardening, MFA, Conditional Access.
- **Detect:** Sentinel Analytics Rules, AMA Log Streaming.
- **Respond:** Account lockdown, IP blocking via NSG.