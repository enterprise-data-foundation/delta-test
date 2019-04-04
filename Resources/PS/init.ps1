####################################################################
#
# DELTATEST v2.0.0
#
# Initialization Script
#
# If deltaTest is properly installed in shared & local environments,
# run the following command to initialize settings and load the
# module. This should be the first line of every test and batch
# script:
#
#   Invoke-Expression "$env:deltaTestLocal\init.ps1"
#
# This script will be copied to your local installation directory
# during the local installation process.
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

# Exit if init already complete.
If ($Global:deltaTestConfig) { Exit }

# Start console logging.
$ScriptName = $(Get-PSCallStack | Select-Object -Property * | Where-Object {$_.ScriptName -ne $null})[-1].ScriptName
$Parent = Split-Path -Path $ScriptName -Parent
$BaseName = (Get-Item $ScriptName).BaseName
Start-Transcript -Path "$($Parent)\$($BaseName).log" -Append -IncludeInvocationHeader

# Import deltaTest module.
Import-Module "$env:deltaTestShared\Resources\PS\deltaTest.psm1" -Force

# Load local config.
$LocalConfig = Import-LocalizedData -FileName 'local_config.psd1'

# Load shared config.
$Global:deltaTestConfig = Import-LocalizedData -BaseDirectory $env:deltaTestShared -FileName 'shared_config.psd1'

# Override shared config with local settings.
if ($LocalConfig.NoInput -ne $null) { $deltaTestConfig.NoInput = $LocalConfig.NoInput }
if ($LocalConfig.ActiveEnvironment -ne $null) { $deltaTestConfig.ActiveEnvironment = $LocalConfig.ActiveEnvironment }
if ($LocalConfig.MedmProcessAgentPath -ne $null) { $deltaTestConfig.MedmProcessAgentPath = $LocalConfig.MedmProcessAgentPath }
if ($LocalConfig.TextDiffExe -ne $null) { $deltaTestConfig.TextDiffExe = $LocalConfig.TextDiffExe }
if ($LocalConfig.TextDiffParams -ne $null) { $deltaTestConfig.TextDiffParams = $LocalConfig.TextDiffParams }
