# Load & configure deltaTest.
Invoke-Expression "$env:deltaTest\init.ps1"

# Display result & pause unless $Global:NoInput is set.
# Show-Execution -Message "Hello, World!"

$deltaTestConfig.NoInput

Read-Host "Press Enter"