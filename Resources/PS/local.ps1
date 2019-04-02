####################################################################
#
# DELTATEST v2.0.0
#
# Local Configuration Manager
#
# This script gives the non-admin user the ability to manage his 
# local configuration, including:
#
# -NoInput: if true, test execution proceeds without user input or
#  diff visualization.
#
# -ActiveEnvironment: must be one of those specified in deltaTest 
#  shared repository file config_shared.psd1
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

