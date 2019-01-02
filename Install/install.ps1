param(
    [bool]$NoInput,
    [string]$ActiveEnvironment,
    [string]$MedmProcessAgentPath
)

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
{
    # We are running "as Administrator" - so change the title and background color to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Elevated)"
    $Host.UI.RawUI.BackgroundColor = "DarkBlue"
    clear-host
}

else
{
    # We are not running "as Administrator" - so relaunch as administrator
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Arguments += " -NoInput `$$NoInput"
    if ($ActiveEnvironment) { $newProcess.Arguments += " -ActiveEnvironment $ActiveEnvironment" } 
    if ($MedmProcessAgentPath) { $newProcess.Arguments += " -MedmProcessAgentPath $MedmProcessAgentPath" } 

    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
   
    # Exit from the current, unelevated, process
    exit
}

$ModuleDir = Split-Path $PSScriptRoot -Parent
$RegistryPath = "HKCU:\Software\EnterpriseTestFoundation\deltaTest"

# BEGIN
Write-Host "`nThank you for installing deltaTest!"

# Check PS Version
Write-Host "`nChecking PowerShell version..."
Write-Host "Current PowerShell version: $($PSVersionTable.PSVersion.ToString())"

$MinPSVersion = 3
If ($PSVersionTable.PSVersion.Major -ge $MinPSVersion) {
    Write-Host "No change required."
}
Else {
	Write-Host "ERROR: deltaTest requires Powershell version $MinPSVersion or better!" -ForegroundColor Yellow
	[void](Read-Host "`nPress Enter to exit")
	Exit
}	

# Check execution policy.
Write-Host "`nChecking execution policy..."
$CurrentExecutionPolicy = (Get-ExecutionPolicy).ToString()
Write-Host "Current Execution Policy: $CurrentExecutionPolicy"

If (("Unrestricted", "Bypass").Contains($CurrentExecutionPolicy)) {
    Write-Host "No change required."
}
Else {
    Write-Host "Setting Execution Policy to Unrestricted... " -NoNewline
    Set-ExecutionPolicy Unrestricted -Force
    Write-Host "Done!"
}

# Check SqlServer module.
Write-Host "`nChecking SqlServer module..."

If (Get-Module -ListAvailable -Name "SqlServer") {
    Write-Host "SqlServer module is already installed!"
}
Else {
    Write-Host "Installing SqlServer module... " -NoNewline 
    Install-Module -Name SqlServer -Force
    Write-Host "Done!"
}

# Configure registry.
Write-Host "`nConfiguring Windows Registry... "

If (!(Test-Path $RegistryPath)) { New-Item -Path $RegistryPath -Force | Out-Null }

$Global:NoInput = $NoInput
if ($ActiveEnvironment) { $Global:ActiveEnvironment = $ActiveEnvironment }
if ($MedmProcessAgentPath) { $Global:MedmProcessAgentPath = $MedmProcessAgentPath }

Invoke-Expression "$ModuleDir\config.ps1 -Install"

Write-Host "`n$RegistryPath\ModuleDir = $ModuleDir"
New-ItemProperty -Path $RegistryPath -Name "ModuleDir" -Value $ModuleDir -PropertyType String -Force | Out-Null
[Environment]::SetEnvironmentVariable("deltaTest", $ModuleDir, "Machine")

If (!$NoInput) { $Global:NoInput = ($(Read-UserEntry -Label "Suppress user input for unattended testing" -Default $(If ($Global:NoInput) { "Y" } Else { "N" }) -Pattern "Y|N") -eq "Y") }
Write-Host "`n$RegistryPath\NoInput = $Global:NoInput"
New-ItemProperty -Path $RegistryPath -Name "NoInput" -Value $Global:NoInput -PropertyType Binary -Force | Out-Null

If (!$ActiveEnvironment) { $Global:ActiveEnvironment = Read-UserEntry -Label "Default active environment" -Default $Global:ActiveEnvironment -Pattern "\w+" }
Write-Host "`n$RegistryPath\ActiveEnvironment = $Global:ActiveEnvironment"
New-ItemProperty -Path $RegistryPath -Name "ActiveEnvironment" -Value $Global:ActiveEnvironment -PropertyType String -Force | Out-Null

If (!$MedmProcessAgentPath) { $Global:MedmProcessAgentPath = Read-UserEntry -Label "MEDM Process Agent path" -Default $Global:MedmProcessAgentPath -Pattern ".+" }
Write-Host "`n$RegistryPath\MedmProcessAgentPath = $Global:MedmProcessAgentPath"
New-ItemProperty -Path $RegistryPath -Name "MedmProcessAgentPath" -Value $Global:MedmProcessAgentPath -PropertyType String -Force | Out-Null

Write-Host "Done!"

# Check WinMerge installation.
If (!$Global:NoInput) {
    Write-Host "`nChecking WinMerge installation..."

    If (Test-Installed "WinMerge") {
        Write-Host "WinMerge is already installed!"
    }
    Else {
        Write-Host "Installing WinMerge... " -NoNewline 
        $WinMergeExePath = "$PSScriptRoot\WinMerge-2.14.0-Setup.exe"
        $WinMergeExeParams = "/SILENT" # http://www.jrsoftware.org/ishelp/index.php?topic=setupcmdline
        & $WinMergeExePath $WinMergeExeParams | Write-Host
        Write-Host "Done!"
    }
}

# END
Write-Host "`nLocal deltaTest installation complete!"
If (!$Global:NoInput) { [void](Read-Host "`nPress Enter to exit") }
