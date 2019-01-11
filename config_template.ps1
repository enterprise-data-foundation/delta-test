param(
    [switch]$Install
)

# Pull global variables from Windows Registry.
$RegistryPath = "HKLM:\Software\EnterpriseTestFoundation\deltaTest"
Get-Item -Path $RegistryPath | Select-Object -ExpandProperty Property | ForEach-Object {
    $PropertyName = $_
    switch -Wildcard ($(Get-ItemPropertyValue -Path $RegistryPath -Name $PropertyName).GetType()) {
        "byte*" {
            $PropertyValue = [bool](Get-ItemPropertyValue -Path $RegistryPath -Name $PropertyName)
        }

        default {
            $PropertyValue = Get-ItemPropertyValue -Path $RegistryPath -Name $PropertyName
        }
    }
    Set-Variable -Name $PropertyName -Value $PropertyValue -Scope Global
}

# Set global variables not populated in Windows Registry.

# MEDM installation path.
If (!$MedmProcessAgentPath) { $Global:MedmProcessAgentPath = "C:\Program Files\Markit Group\Markit EDM_17_1_132_0\CadisProcessAgent.exe" }

# WinMerge command line config.
If (!$TextDiffExe) { $Global:TextDiffExe = "C:\Program Files (x86)\WinMerge\WinMergeU.exe" }
If (!$TextDiffParams) { $Global:TextDiffParams = @("/e", "/s", "/u", "/wl", "/wr", "/dl", "Current Result", "/dr", "Certified Result", "{{CurrentResult}}", "{{CertifiedResult}}") }

# Default script type for results reporting.
If (!$SqlScriptType) { $Global:SqlScriptType = "Sql Script" }

# Default directory for report files..
If (!$ReportFolder) { $Global:ReportFolder = "C:\deltaTest\Results" }

# Execute tests with user input by default.
If (!$NoInput) { $Global:NoInput = $false }

# Active Environment.
If (!$ActiveEnvironment) { $Global:ActiveEnvironment = "DEV" }

# Specify per-environment settings here.
switch ($ActiveEnvironment) {
    "DEV" {
        $Global:EnvMedmDbServer = "DevServerName"
        $Global:EnvMedmDbName = "DevDbName"
        $Global:EnvBbgPxFileInDir = "\\netshare\DEV\bbg\price\IN"
        $Global:EnvBbgSecFileInDir = "\\netshare\DEV\bbg\security\IN"
        break
    }

    "TEST" {
        $Global:EnvMedmDbServer = "TestServerName"
        $Global:EnvMedmDbName = "TestDbName"
        $Global:EnvBbgPxFileInDir = "\\netshare\TEST\bbg\price\IN"
        $Global:EnvBbgSecFileInDir = "\\netshare\TEST\bbg\security\IN"
        break
    }

    default {
        Write-Host "Unknown environment!"
        If (!$Install) { 
            [void](Read-Host "Press Enter to exit")
            [Environment]::Exit(1)
        }
    }
}

# Import deltaTest module.
Import-Module "$ModuleDir\deltaTest.psm1" -NoClobber
