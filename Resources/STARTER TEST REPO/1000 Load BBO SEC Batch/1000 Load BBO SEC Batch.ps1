####################################################################
#
# DELTATEST v2.0.0
#
# Test Script
#
# Place this header at the top of every test to support automated
# upgrades to your test archive.
#
# Initialize deltaTest.
  Invoke-Expression "$env:deltaTestLocal\init.ps1"
# 
####################################################################

# Copy test file to input directory.
Copy-Item -Path "BBO_SEC_1.psv" -Destination $(Get-ActiveEnvironment).DirInBboSec
Copy-Item -Path "BBO_SEC_2.psv" -Destination $(Get-ActiveEnvironment).DirInBboSec

# Execute test.
$result = Test-MedmComponent `
    -TestName "1000 Load BBO SEC Batch" `
    -ComponentType "Solution" `
    -ComponentName "1000 Load BBO SEC Batch" `
    -ResultSqlDir "./Result" `
    -ResultSqlFiles "t_Load_FileMonitor.sql, t_Exception_Stage.sql, t_Load_BBO_SEC_Store.sql,  t_Load_BBO_SEC_Failed.sql, t_Load_BBO_SEC_Stage.sql, t_Load_BBO_SEC.sql" `
    -OutputTable `
    -TestResultPath "Result.txt" `
    -CertifiedResultPath "Result.certified.txt"

# Display result & pause unless $Global:NoInput is set.
Show-Execution -Result $result -Message "Test complete!"

# Return result to calling script.
return $result
