// Title: Full Incident Timeline Reconstruction
// Strategy: Uses a 'Union' operator to pull from multiple tables to build a 360-degree view of an attacker's actions.
let TargetUser = "Admin-Babatunde"; // Change to the account being investigated
let TargetIP = "203.0.113.5";      // Change to the attacker's source IP
union 
(SecurityEvent | where TargetAccount has TargetUser or IpAddress == TargetIP | project TimeGenerated, Action = strcat("Host Activity: ", tostring(EventID)), Details = Activity),
(AzureActivity | where Caller == TargetUser or CallerIpAddress == TargetIP | project TimeGenerated, Action = strcat("Azure Change: ", OperationNameValue), Details = ActivityStatusValue),
(AzureDiagnostics | where Identity_s has TargetUser or CallerIPAddress == TargetIP | project TimeGenerated, Action = "Key Vault Access", Details = OperationName)
| sort by TimeGenerated asc