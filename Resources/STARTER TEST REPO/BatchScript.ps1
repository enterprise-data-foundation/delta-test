####################################################################
#
# DELTATEST v2.0.0
#
# Batch Script
#
# Note that the Invoke-deltaTest cmdlet has the following syntax:
#
# Invoke-deltaTest
#   -TestPath "<Path to test>"
#   [-NoInput $true|$false]
#   [-ActiveEnvironment "<Active Environment>"]
#   [-ProcessAgentPath "<Medm Process Agent Path>"]
# 
# The optional arguments override corresponding shared or local 
# $deltaTestConfig settings for the duration of test execution. 
#
# Place this header at the top of every test to support automated
# upgrades to your test archive.
#
# Initialize deltaTest.
  Invoke-Expression "$env:deltaTestLocal\init.ps1"
# 
####################################################################
 
# Invoke tests.
Invoke-deltaTest ".\7000 Exception Process\7000 Exception Process.ps1" -NoInput $True
Invoke-deltaTest ".\1000 Load BBO SEC Batch\1000 Load BBO SEC Batch.ps1" -NoInput $True

Read-Host "Test execution complete! Press Enter to exit"