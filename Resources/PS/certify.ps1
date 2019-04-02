####################################################################
#
# DELTATEST v2.0.0
#
# Certification Script
#
# Running this script will create a copy of the input file such that
# if the original filename is file.ext, the resulting copy's name
# will be file.certified.ext
#
# To run this script manually, just drag a file from your desktop 
# and drop it on the +CERTIFY shortcut in the shared deltaTest 
# repository!
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

$Parent = Split-Path -Path $Path -Parent
$BaseName = (Get-Item $Path).BaseName
$Extension = (Get-Item $Path).Extension

Copy-Item -Path $Path -Destination "$($Parent)\$($BaseName).certified$($Extension)"
