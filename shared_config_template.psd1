####################################################################
#
# DELTATEST v2.0.0
#
# Shared Configuration File
#
# The settings below are available to all users who have installed
# deltaTest locally against this repository.
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
	# DEFAULT LOCAL CONFIGURATIONS. These can be overridden locally.
	
	# If true, tests will execute without user input or diff visualization.
	NoInput = $false
	
	# Tests will be run against this environment. Must be specified in Environments below.
	ActiveEnvironment = "DEV"
	
	# Path to Markit EDM command line executable.
	ProcessAgentPath = "C:\Program Files\Markit Group\Markit EDM_18_2_12_1\CadisProcessAgent.exe"
	
	# Path to text differencing engine executable.
	TextDiffExe = "C:\Program Files (x86)\WinMerge\WinMergeU.exe"
	
	# Text differencing engine command line params. {{CurrentResult}} and {{CertifiedResult}} 
	# will be replaced by the appropriate paths at run time.
	TextDiffParams = @("/e", "/s", "/u", "/wl", "/wr", "/dl", "Current Result", "/dr", "Certified Result", "{{CurrentResult}}", "{{CertifiedResult}}")

	# SHARED CONFIGURATIONS. These cannot be overridden locally.

	# Colors used on interactive screens.
	Colors = @{
		Title = 'Cyan'
		Label = 'White'
		Prompt = 'Yellow'
		Description = 'Gray'
		Default = 'Gray'
		Pattern = 'Gray'
		Error = 'Red'
		Confirmation = 'Green'
	}

	# deltaTest version number.
	Version = "2.0.0"

	# ENVIRONMENT-SPECIFIC SETTINGS. These are global and cannot be overridden. Add as many 
	# environments as needed, but each environment should express the same properties to 
	# support consistent testing across environments. Variable names and values are arbitrary: 
	# they are only consumed in test scripts, and can be whatever they need to be to support 
	# testing.
	
	Environments = @{
		DEV = @{
				MedmDbServer = "DevServerName"
				MedmDbName = "DevDbName"
				DirInBbgPrc = "\\netshare\Environments\DEV\Inbound\BBG\PRC"
				DirInBbgSec = "\\netshare\Environments\DEV\Inbound\BBG\SEC"
		}
		TEST = @{
				MedmDbServer = "TestServerName"
				MedmDbName = "TestDbName"
				DirInBbgPrc = "\\netshare\Environments\TEST\Inbound\BBG\PRC"
				DirInBbgSec = "\\netshare\Environments\TEST\Inbound\BBG\SEC"
		}
		STAGE = @{
				MedmDbServer = "StageServerName"
				MedmDbName = "StageDbName"
				DirInBbgPrc = "\\netshare\Environments\STAGE\Inbound\BBG\PRC"
				DirInBbgSec = "\\netshare\Environments\STAGE\Inbound\BBG\SEC"
		}
		PROD = @{
				MedmDbServer = "ProdServerName"
				MedmDbName = "ProdDbName"
				DirInBbgPrc = "\\netshare\Environments\PROD\Inbound\BBG\PRC"
				DirInBbgSec = "\\netshare\Environments\PROD\Inbound\BBG\SEC"
		}
	}
}

