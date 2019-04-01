param(
    [string]$LocalDir = "C:\Program Files\deltaTest",
    [string]$NoInputStr,
    [string]$ActiveEnvironment,
    [string]$MedmProcessAgentPath
)

# ELEVATE SCRIPT IF NECESSARY.

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# If we are currently running as Administrator...
if ($myWindowsPrincipal.IsInRole($adminRole))
{
    # ... then change the title & background color.
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Elevated)"
    $Host.UI.RawUI.BackgroundColor = "DarkBlue"
    clear-host
}

else
{
    # ... otherwise relaunch as administrator.
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;

    if ($LocalDir) { $newProcess.Arguments += " -LocalDir '$LocalDir'" }
    if ($NoInputStr) { $newProcess.Arguments += " -NoInputStr `$$NoInputStr" }
    if ($ActiveEnvironment) { $newProcess.Arguments += " -ActiveEnvironment '$ActiveEnvironment'" } 
    if ($MedmProcessAgentPath) { $newProcess.Arguments += " -MedmProcessAgentPath '$MedmProcessAgentPath'" } 

    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
   
    # Exit from the current, unelevated, process
    exit
}

# Validate & hydrate params.
$ModuleDir = $PSScriptRoot | Split-Path -Parent | Split-Path -Parent 
$SharedConfig = Import-LocalizedData -BaseDirectory $ModuleDir -FileName 'shared_config.psd1'

if (!$NoInputStr) { $NoInput = $SharedConfig.NoInput}
else { $NoInput = $("`$$NoInputStr") }

if (!$ActiveEnvironment) { $ActiveEnvironment = $SharedConfig.ActiveEnvironment }
if (!$MedmProcessAgentPath) { $MedmProcessAgentPath = $SharedConfig.MedmProcessAgentPath }

# BEGIN
Write-Host "`nThank you for installing deltaTest v2.0.0!"

# Check PS Version
Write-Host "`nChecking PowerShell version..."
Write-Host "Current PowerShell version: $($PSVersionTable.PSVersion.ToString())"

$MinPSVersion = 5
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


# Write local config file. 
Write-Host "`nWriting local config file..." -NoNewline

if (!(Test-Path $LocalDir -PathType Container)) { New-Item $LocalDir -ItemType "directory" }

$LocalConfigData = @"
#
# DELTATEST 2.0.0
#
# Local configuration file. These override shared default settings in $($ModuleDir)\shared_config.psd1
#

@{
    # Points to the shared deltaTest repo.
    ModuleDir = "$ModuleDir"

	# If true, tests will execute without user input or diff visualization.
	NoInput = `$$NoInput
	
	# Tests will be run against this environment. Must be specified in $($ModuleDir)\shared_config.psd1
	ActiveEnvironment = "$ActiveEnvironment"
	
	# Path to Markit EDM command line executable.
	MedmProcessAgentPath = "$MedmProcessAgentPath"
	
	# Path to text differencing engine executable.
	TextDiffExe = "$SharedConfig.TextDiffExe"
	
	# Text differencing engine command line params. {{CurrentResult}} and {{CertifiedResult}} 
    # will be replaced by the appropriate paths at run time.
	TextDiffParams = @("$($SharedConfig.TextDiffParams -Join """, """)")
}
"@ | Out-File -FilePath "$LocalDir\local_config.psd1"

Write-Host "Done!"

# Create environment variable.
Write-Host "`nCreating %deltaTest% environment variable..." -NoNewline
[Environment]::SetEnvironmentVariable('deltaTest', $LocalDir, 'Machine')
Write-Host "Done!"

# Check WinMerge installation.
function Test-Installed( $program ) {
    
    $x86 = ((Get-ChildItem 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall') |
        Where-Object { $_.GetValue('DisplayName') -like "*$program*" } ).Length -gt 0;

    $x64 = ((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue('DisplayName') -like "*$program*" } ).Length -gt 0;

    return $x86 -or $x64;
}

If (!$NoInput) {
    Write-Host "`nChecking WinMerge installation..."

    If (Test-Installed 'WinMerge') {
        Write-Host 'WinMerge is already installed!'
    }
    Else {
        Write-Host 'Installing WinMerge... ' -NoNewline 
        $WinMergeExePath = "$($PSScriptRoot | Split-Path -Parent)\WinMerge-2.14.0-Setup.exe"
        $WinMergeExeParams = '/SILENT' # http://www.jrsoftware.org/ishelp/index.php?topic=setupcmdline
        & $WinMergeExePath $WinMergeExeParams | Write-Host
        Write-Host 'Done!'
    }
}

# END
Write-Host "`nLocal deltaTest installation complete!"
If (!$NoInput) { [void](Read-Host "`nPress Enter to exit") }


