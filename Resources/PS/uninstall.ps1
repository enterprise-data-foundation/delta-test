####################################################################
#
# DELTATEST v2.0.0
#
# Uninstaller Script
#
# This script uninstalls deltaTest from the local machine. To 
# uninstall deltaTest manually, navigate to the shared deltaTest
# repository and double-click the +UNINSTALL shortcut. 
#
# You must have local admin permissions to run this script.
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
    [string]$LocalDir = "C:\deltaTest",
    [string]$NoInput,
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

    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
   
    # Exit from the current, unelevated, process
    exit
}

# BEGIN
Write-Host '*** deltaTest v2.0.0 Uninstaller ***' -ForegroundColor Cyan

if (!$env:deltaTestLocal) { 
    Write-Host "`ndeltaTest is not installed on this machine!" -ForegroundColor White
    [void](Read-Host "`nPress Enter to exit")
    Exit
}

# Initialize deltaTest.
Invoke-Expression "$env:deltaTestLocal\init.ps1"

# Validate uninstall.
if (((Read-UserEntry -Label 'CONFIRMATION' -Description "Are you sure you wish to uninstall deltaTest, including`nthe local config directory and environment variables?" -Default 'n' -Pattern 'y|n') -eq 'n')) { Exit }

# Delete local config directory.
Write-Host "`nDeleting local config directory at $env:deltaTestLocal..." -NoNewline
Remove-Item -LiteralPath $env:deltaTestLocal -Force -Recurse
Write-Host "Done!"

# Delete environment variables.
Write-Host "`nDeleting %deltaTestLocal% environment variable..." -NoNewline
[Environment]::SetEnvironmentVariable('deltaTestLocal', $null, 'Machine')
Write-Host "Done!"

Write-Host "Deleting %deltaTestShared% environment variable..." -NoNewline
[Environment]::SetEnvironmentVariable('deltaTestShared', $null, 'Machine')
Write-Host "Done!"

# END
Write-Host "`nLocal deltaTest uninstall complete!" -ForegroundColor White
[void](Read-Host "`nPress Enter to exit")


