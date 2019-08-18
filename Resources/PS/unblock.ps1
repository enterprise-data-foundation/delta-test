####################################################################
#
# DELTATEST v2.0.0
#
# File Unblocker Script
#
# This script will self-elevate and recursively unblock any files 
# within its own directory or below. To run the script manually, 
# just drag a directory from your desktop and drop it on the 
# +UNBLOCK shortcut in the shared deltaTest repository!
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

Param(
    [string]$Path = $PSScriptRoot
) 

function Get-Files {
    Param(
        [string]$Path
    ) 

    $files = @()

    foreach ($item in Get-ChildItem $Path)
    {
        if (Test-Path $item.FullName -PathType Container) 
        {
            Get-Files $item.FullName
        } 

        $files += $item.FullName 
    } 

    return $files
}

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
    $newProcess.Arguments += " -Path '$Path'"

    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
   
    # Exit from the current, unelevated, process
    exit
}


Set-ExecutionPolicy Unrestricted -Force
Write-Host "Execution Policy set to Unrestricted."

Write-Host "`nRecursively unblocking all files at and below"
Write-Host "$Path`n"
Get-Files -Path $Path | foreach {
    $File = $_
    Write-Host "Unblocking $File"
    Unblock-File $File
}

Read-Host "`nUnblocking complete! Press Enter to exit"