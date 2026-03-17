# 07 - Detection Engineering: From Logs to Alerts

## 🧠 The Detection Strategy
Detection engineering is not about alerting on every event; it is about identifying **signals** within the **noise**. My strategy for this lab focused on two high-risk areas: **Identity Compromise** and **Resource Abuse**.

I mapped these detections to the **MITRE ATT&CK** framework to ensure comprehensive coverage of the attacker's simulated lifecycle.

---

## 🔍 Key Detection: RDP Brute-Force (T1110.001)
**Goal:** Detect an active brute-force attempt before a successful foothold is gained.
**Logic:** Identify a high volume of failed logins (Event 4625) from a single IP address within a short time window.

### KQL Query:
```kusto
DeviceLogonEvents
| where ActionType == "LogonFailed"
| where LogonType == "RemoteInteractive" // RDP Specific
| summarize FailureCount = count() by RemoteIP, DeviceName, bin(TimeGenerated, 5m)
| where FailureCount >= 10
| project TimeGenerated, DeviceName, RemoteIP, FailureCount

False Positive Consideration: This might trigger on a user who forgot their password. I set the threshold to 10 attempts in 5 minutes to reduce noise while maintaining security.

📈 Key Detection: Successful Logon after Brute-Force
Goal: Detect when an attacker finally "guesses" the right password.
Logic: Correlate a history of failed logins from an IP followed by a successful login (Event 4624) from that same IP.

KQL Query:
Code snippet
let BruteForceIPs = DeviceLogonEvents
| where ActionType == "LogonFailed"
| summarize count() by RemoteIP
| where count_ > 10
| project RemoteIP;
DeviceLogonEvents
| where ActionType == "LogonSuccess"
| where RemoteIP in (BruteForceIPs)
🔑 Key Detection: Key Vault Secret Access (T1530)
Goal: Detect unauthorized access to sensitive application secrets.
Logic: Alert when a user account that does not typically access the Key Vault performs a SecretGet operation.

KQL Query:
Code snippet
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.KEYVAULT"
| where OperationName == "SecretGet"
| project TimeGenerated, Resource, CallerIPAddress, Identity_s, OperationName

🚀 Microsoft Sentinel Integration
I integrated these queries into Sentinel Analytics Rules with the following settings:

Severity: Medium (Brute-force), High (Successful login after Brute-force).

Automation: Configured automated tasks to tag the incidents for priority review.

Incident Grouping: Grouped related alerts into a single incident to prevent "Alert Fatigue."

Figure 12 — KQL query used to detect repeated failed authentication attempts indicating brute-force activity.