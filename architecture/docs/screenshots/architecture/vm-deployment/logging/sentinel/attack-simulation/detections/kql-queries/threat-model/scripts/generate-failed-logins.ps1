generate-failed-logins.ps1
Description

This script simulates a brute-force login attack by generating repeated failed authentication attempts.

These failed logins generate Windows Event ID 4625, which can be detected by SIEM systems.

The resulting logs allow analysts to build detection queries using Kusto Query Language (KQL) in Microsoft Sentinel.

This simulation helps demonstrate detection engineering capabilities in a controlled lab environment.

PowerShell Script
# generate-failed-logins.ps1

$targetUser = "Administrator"

Write-Host "Generating failed login attempts..."

for ($i = 1; $i -le 20; $i++) {

    Write-Host "Attempt $i"

    net use \\localhost\ipc$ /user:$targetUser WrongPassword123 2>$null

    Start-Sleep -Seconds 2
}

Write-Host "Failed login simulation completed."