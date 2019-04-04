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

# Execute test.
$result = Test-MedmComponent `
    -TestName "7000 Exception Process" `
    -SetupSqlDir "./Setup" `
    -SetupSqlFiles "t_Exception_Process.csv, t_Exception_Status.csv, t_Exception_Step.csv, t_Exception_Code.csv, t_Exception_Rule.csv, t_Exception.csv, t_Exception_Xref.csv, t_Exception_Stage.csv" `
    -ComponentType "Solution" `
    -ComponentName "7000 Exception Process" `
    -ResultSqlDir "./Result" `
    -ResultSqlFiles "t_Exception_Process.sql, t_Exception_Status.sql, t_Exception_Step.sql, t_Exception_Code.sql, t_Exception_Rule.sql, t_Exception_Stage.sql, t_Exception.sql, v_Exception_Xref.sql, t_Log.sql" `
    -OutputTable `
    -CleanupSqlFiles "Cleanup.sql" `
    -TestResultPath "Result.txt" `
    -CertifiedResultPath "Result.certified.txt"

# Display result & pause unless $Global:NoInput is set.
Show-Execution -Result $result -Message "Test complete!"

# Return result to calling script.
return $result
