####################################################################
#
# DELTATEST v2.0.0
#
# Hello World Test
#
# Right-click on this test script and select Run with Powershell.
# If it responds with, "Hello, World!", deltaTest is properly 
# installed!
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

# Initialize deltaTest.
Invoke-Expression "$env:deltaTest\init.ps1"

# Display result & pause unless $deltaTestConfig.NoInput is $True.
Show-Execution -Message "Hello, World!"
