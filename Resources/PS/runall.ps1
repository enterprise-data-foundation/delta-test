####################################################################
#
# DELTATEST v2.0.0
#
# Run All Scripts
#
# This script will recursively run all tests under $Path.
#
# To run this script manually, just drag a directory from your 
# desktop and drop it on the +RUNALL shortcut in the shared 
# deltaTest repository!
#
# This shortcut is portable. Place it anywhere convenient on the 
# local machine.
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

param (
    [string]$Path
)

If (!$Path) {
    Write-Host "To execute all .PS1 scripts in a directory with recursion, simply drag & drop `nthe directory on the +RUNALL shortcut. Feel free to copy the shortcut `nto any convenient location." 
}

Else {
    # Initialize deltaTest.
    Invoke-Expression "$env:deltaTestLocal\init.ps1"

    # Run all scripts in child directories.
    $result = @()
    Get-Files -Path $Path -Include "\.ps1" | foreach { 
        $FilePath = $_
        "Running " + $FilePath | Write-Host
        $parent = Split-Path -Path $FilePath -Parent
        Set-Location -Path $parent
        $result += Invoke-deltaTest -TestPath $FilePath -NoInput $true
    }

    Write-Host "All scripts executed!"
}

[void](Read-Host "`nPress Enter to continue")