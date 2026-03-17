// Title: High-Frequency Automated Failed Logins
// Strategy: Identify automated credential guessing by monitoring for bursts of failed logons (Event 4625).
// Focus: Specifically targets 'Unknown user name or bad password' (Status 0xc000006d).

SecurityEvent
| where EventID == 4625
| where Status == "0xc000006d" // Specific Windows error for bad credentials
| summarize FailureCount = count() by TargetAccount, IpAddress, Computer, bin(TimeGenerated, 1m)
| where FailureCount > 30 // High threshold to catch your simulation script
| project TimeGenerated, TargetAccount, AttackerIP = IpAddress, TargetHost = Computer, FailureCount
| sort by FailureCount desc

Windows Security Event Log: Audit Failures (4625)	Verification of the local attack telemetry. This screenshot of the Windows Event Viewer on APP-SRV01 shows a rapid burst of "Audit Failure" events, proving the attack was logged by the OS.

Windows Security Event Log: Audit Failures (4625)	Verification of the local attack telemetry. This screenshot of the Windows Event Viewer on APP-SRV01 shows a rapid burst of "Audit Failure" events, proving the attack was logged by the OS