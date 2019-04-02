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
  Invoke-Expression "$env:deltaTest\init.ps1"
# 
####################################################################

# Execute test.
$result = Test-MedmComponent `
    -TestName "4000 Master SEC" `
    -SetupSqlDir "./SetupSql" `
    -SetupSqlFiles "T_BBO_EQUITY_FUND_SEC.sql, T_BBO_EQUITY_SEC.csv, T_OVERRIDE_SECURITY.sql, T_OVERRIDE_SECURITY_EXPIRY.sql" `
    -ComponentType "Solution" `
    -ComponentName "4000 Master SEC" `
    -ResultSqlDir "./ResultSql" `
    -ResultSqlFiles "T_BBO_EQUITY_SEC.sql, T_BBO_EQUITY_FUND_SEC.sql, T_PREMASTER_SECURITY.sql, T_OVERRIDE_SECURITY.sql, T_OVERRIDE_SECURITY_EXPIRY.sql, T_MASTER_SECURITY.sql" `
    -OutputTable `
    -CleanupSqlFiles "Cleanup.sql" `
    -TestResultPath "Result.txt" `
    -CertifiedResultPath "Result.certified.txt"

# Display result & pause unless $Global:NoInput is set.
Show-Execution -Result $result -Message "Test complete!"

# Return result to calling script.
return $result
