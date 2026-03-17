// Title: Hunt for Successful Logon after Brute Force
// Strategy: Identify IPs that had multiple failures and subsequently a successful login
let BruteForceIPs = SecurityEvent
| where EventID == 4625
| summarize count() by IpAddress
| where count_ > 10
| project IpAddress;
SecurityEvent
| where EventID == 4624 // Successful Login
| where IpAddress in (BruteForceIPs)
| summarize SuccessCount = count() by IpAddress, TargetAccount, Computer
| project IpAddress, TargetAccount, Computer, SuccessCount