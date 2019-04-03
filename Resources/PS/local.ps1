####################################################################
#
# DELTATEST v2.0.0
#
# Local Configuration Manager
#
# This script gives the non-admin user the ability to manage local 
# deltaTest configuration, including:
#
# -NoInput: if $true, test execution proceeds without user input or
#  diff visualization. Use to enable unattended, automated testing.
#
# -ActiveEnvironment: must be one of those specified in deltaTest 
#  shared repository file shared_config.psd1
#
# -MedmProcessAgentPath: The full path to CadisProcessAgent.exe.
#  Use if Markit EDM is installed locally in a non-default 
#  directory.
#
# -TextDiffExe: Path to text differencing engine executable. Supports 
#  non-default WinMerge installations and other text differencing 
#  engines. 
# 
# -TextDiffParams: Text differencing engine command line params. 
#  {{CurrentResult}} and {{CertifiedResult}} will be replaced by the 
#  appropriate paths at run time.
#
# To run this script manually, just double-click on the +LOCAL 
# shortcut in the shared deltaTest repository!
# 
####################################################################
#
# Copyright 2016-2019 by the following contributors:
#
#   Continuus Technologies, LLC
#   Enterprise Data Foundation, Inc.
#   HexisData, Inc.
#   HotQuant, Inc. 
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
####################################################################

param(
    [string]$NoInput,
    [string]$ActiveEnvironment,
    [string]$MedmProcessAgentPath,
    [string]$TextDiffExe,
    [string[]]$TextDiffParams,
    [switch]$Interactive
)

function Write-LocalConfig {
    $LocalConfigData = @"
####################################################################
#
# DELTATEST v2.0.0
#
# Local Config File
#
# The settings below override the default settings in your shared 
# deltaTest repository at $env:deltaTestShared\shared_config.ps1
#
# To use the shared default, set the local value to `$null.
#
####################################################################
#
# Copyright 2016-2019 by the following contributors:
#
#   Continuus Technologies, LLC
#   Enterprise Data Foundation, Inc.
#   HexisData, Inc.
#   HotQuant, Inc. 
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
####################################################################

@{
    # If true, tests will execute without user input or diff visualization. 
    NoInput = $(if ($NoInput) { "`$$NoInput" } else { '$null' }) # SHARED DEFAULT: `$$($SharedConfig.NoInput)
	
    # Tests will be run against this environment. Must be one of those 
    # specified in $env:deltaTestShared\shared_config.ps1
    ActiveEnvironment = $(if ($ActiveEnvironment) { "'$ActiveEnvironment'" } else { '$null' }) # SHARED DEFAULT: '$($SharedConfig.ActiveEnvironment)'
	
    # Path to Markit EDM command line executable.
    MedmProcessAgentPath = $(if ($MedmProcessAgentPath) { "'$MedmProcessAgentPath'" } else { '$null' }) # SHARED DEFAULT: '$($SharedConfig.MedmProcessAgentPath)' 
	
    # Path to text differencing engine executable.
    TextDiffExe = $(if ($TextDiffExe) { "'$TextDiffExe'" } else { '$null' }) # SHARED DEFAULT: '$($SharedConfig.TextDiffExe)'
	
    # Text differencing engine command line params. {{CurrentResult}} and {{CertifiedResult}} will be replaced by the appropriate paths at run time.
    TextDiffParams = $(if ($TextDiffParams) { "@('$($TextDiffParams -Join "', '")')" } else { '$null' }) # SHARED DEFAULT: @('$($SharedConfig.TextDiffParams -Join "', '")')
}
"@ | Out-File -FilePath "$env:deltaTest\local_config.psd1"
}

# Import deltaTest module.
Import-Module "$env:deltaTestShared\Resources\PS\deltaTest.psm1"

# Load shared config.
$SharedConfig = Import-LocalizedData -BaseDirectory $env:deltaTestShared -FileName "shared_config.psd1"

if (!$Interactive) { Write-LocalConfig; Exit }

Write-Host 'deltaTest 2.0.0 Local Config Manager'

do {
    Write-Host @"

Please select from the following options. Set value to `$null to use shared default:

1. Change NoInput 
   Current value: `$$(if($NoInput) { $NoInput } else { 'null' })
   Shared default: `$$($SharedConfig.NoInput)

2. Change ActiveEnvironment 
   Current value: $(if($ActiveEnvironment) { $ActiveEnvironment } else { '$null' })
   Shared default: $($SharedConfig.ActiveEnvironment)

3. Change MedmProcessAgentPath 
   Current value: $(if($MedmProcessAgentPath) { $MedmProcessAgentPath } else { '$null' })
   Shared default: $($SharedConfig.MedmProcessAgentPath)

4. Change TextDiffExe 
   Current value: $(if($TextDiffExe) { $TextDiffExe } else { '$null' })
   Shared default: $($SharedConfig.TextDiffExe)

"@
    
    do { $Choice = Read-Host "Enter your choice, or press Enter with no choice to exit" }
    until (!$Choice -or $Choice -match '[1-4]')

    switch ($Choice) {
        1 { 
            $NoInput = $(Read-UserEntry `
                -Label 'NOINPUT' `
                -Prompt 'When $true, suppresses user input and diff visualization for unattended testing.' `
                -Default "`$$(if($NoInput) { $NoInput } else { 'null' })" `
                -Pattern '\$null|\$true|\$false' `
            ).TrimStart('$')
            break
        }
    }

    if ($Choice) { Write-LocalConfig }

}
until (!$Choice)

