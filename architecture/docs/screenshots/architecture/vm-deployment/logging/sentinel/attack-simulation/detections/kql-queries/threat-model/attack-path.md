# 🛡️ Attack Path Analysis: Perimeter to Crown Jewels

## 🗺️ Visual Path
**[Internet]** --> **[Spoke 1: APP-SRV01]** (Initial Entry) --> **[Hub: VNet Peering]** (Lateral Movement) --> **[Hub: Key Vault]** (Objective)

## 🏗️ Path Breakdown

1.  **Initial Access (The Breach):** The attacker identifies an exposed RDP port on `APP-SRV01`. Despite being in a spoke, the lack of a "Zero-Trust" check at the entry point allows a brute-force attack to succeed.
2.  **Internal Pivot (Lateral Movement):** Because "Allow Forwarded Traffic" is enabled in the Peerings (to allow central monitoring), the attacker uses the compromised `APP-SRV01` as a jump box to reach the Hub network.
3.  **The Endgame (Exfiltration):** The attacker leverages a misconfigured or over-privileged identity to grant themselves "Key Vault Secrets Officer" permissions via the Azure Portal, finally accessing the `kv-prod-secrets`.

## 🛑 Security Gaps Identified
- **Unrestricted NSG:** Port 3389 was open to the entire internet.
- **Identity Weakness:** No MFA enforced on the compromised account.
- **Over-Privileged RBAC:** The account had the ability to modify role assignments.