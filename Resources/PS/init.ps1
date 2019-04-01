# Exit if init already complete.
If ($Global:deltaTestConfig) { Exit }

# Load local config.
$LocalConfig = Import-LocalizedData -FileName 'local_config.psd1'

# Load shared config.
$Global:deltaTestConfig = Import-LocalizedData -BaseDirectory $LocalConfig.ModuleDir -FileName 'shared_config.psd1'

# Override shared config with local settings.
$deltaTestConfig | Add-Member "ModuleDir" $LocalConfig.ModuleDir
if ($LocalConfig.NoInput -ne $null) { $deltaTestConfig.NoInput = $LocalConfig.NoInput }
if ($LocalConfig.ActiveEnvironment -ne $null) { $deltaTestConfig.ActiveEnvironment = $LocalConfig.ActiveEnvironment }
if ($LocalConfig.MedmProcessAgentPath -ne $null) { $deltaTestConfig.MedmProcessAgentPath = $LocalConfig.MedmProcessAgentPath }
if ($LocalConfig.TextDiffExe -ne $null) { $deltaTestConfig.TextDiffExe = $LocalConfig.TextDiffExe }
if ($LocalConfig.TextDiffParams -ne $null) { $deltaTestConfig.TextDiffParams = $LocalConfig.TextDiffParams }

# Start console logging.
$ScriptName = $(Get-PSCallStack | Select-Object -Property * | Where-Object {$_.ScriptName -ne $null})[-1].ScriptName
$Parent = Split-Path -Path $ScriptName -Parent
$BaseName = (Get-Item $ScriptName).BaseName
Start-Transcript -Path "$($Parent)\$($BaseName).log" -Append -IncludeInvocationHeader

# Import deltaTest module.
Import-Module "$($deltaTestConfig.ModuleDir)\Resources\PS\deltaTest.psm1"
