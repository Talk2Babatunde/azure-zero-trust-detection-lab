<#
.SYNOPSIS
    Configures Advanced Audit Policy on Windows Server to ensure high-fidelity telemetry.
.DESCRIPTION
    This script enables auditing for Logon/Logoff and Process Creation, 
    essential for capturing Event IDs 4624, 4625, and 4688.
#>

Write-Host "Setting Advanced Audit Policies for Zero-Trust Pipeline..." -ForegroundColor Cyan

# Audit Logon Failures (Event 4625)
auditpol /set /subcategory:"Logon" /failure:enable

# Audit Logon Success (Event 4624)
auditpol /set /subcategory:"Logon" /success:enable

# Audit Process Creation (Event 4688 - helpful for tracking attacker commands)
auditpol /set /subcategory:"Process Creation" /success:enable

Write-Host "Audit Policies Applied Successfully. AMA Agent can now ingest security telemetry." -ForegroundColor Green