# Load & configure deltaTest.
Invoke-Expression "$(Get-ItemPropertyValue -Path "HKLM:\Software\EnterpriseDataFoundation\deltaTest" -Name "ModuleDir")\config.ps1"

# Display result & pause unless $Global:NoInput is set.
Show-Execution -Message "Hello, World!"
