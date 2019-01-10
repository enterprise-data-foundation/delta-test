# Load & configure deltaTest.
Invoke-Expression "$(Get-ItemPropertyValue -Path "HKCU:\Software\EnterpriseTestFoundation\deltaTest" -Name "ModuleDir")\config.ps1"

# Return result to calling script.
return "BANG!"
