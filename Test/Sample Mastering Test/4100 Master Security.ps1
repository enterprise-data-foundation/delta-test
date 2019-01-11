# Load & configure deltaTest.
Invoke-Expression "$(Get-ItemPropertyValue -Path "HKLM:\Software\EnterpriseTestFoundation\deltaTest" -Name "ModuleDir")\config.ps1"

# Execute test.
$result = Test-MedmComponent `
    -TestName "4100 Master Security" `
    -SetupSqlDir "./SetupSql" `
    -SetupSqlFiles "T_BBO_EQUITY_FUND_SEC.sql,T_BBO_EQUITY_SEC.csv,T_OVERRIDE_SECURITY.sql,T_OVERRIDE_SECURITY_EXPIRY.sql" `
    -ComponentType "Solution" `
    -ComponentName "PPA 4100 Master Security" `
    -ResultSqlDir "./ResultSql" `
    -ResultSqlFiles "T_BBO_EQUITY_SEC.sql,T_BBO_EQUITY_FUND_SEC.sql,T_PREMASTER_SECURITY.sql,T_OVERRIDE_SECURITY.sql,T_OVERRIDE_SECURITY_EXPIRY.sql,T_MASTER_SECURITY.sql" `
    -OutputTable `
    -CleanupSqlFiles "Cleanup.sql" `
    -TestResultPath "Result.txt" `
    -CertifiedResultPath "Result.certified.txt"

# Display result & pause unless $Global:NoInput is set.
Show-Execution -Result $result -Message "Test complete!"

# Return result to calling script.
return $result
