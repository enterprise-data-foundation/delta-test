# Load & configure deltaTest.
Invoke-Expression "$(Get-ItemPropertyValue -Path "HKLM:\Software\EnterpriseTestFoundation\deltaTest" -Name "ModuleDir")\config.ps1"

# Copy test file to input directory.
Copy-Item -Path "equity_namr.dif.20180917" -Destination $Global:EnvBboSecFileInDir

# Execute test.
$result = Test-MedmComponent `
    -TestName "1000 BBO Equity Load" `
    -ComponentType "Solution" `
    -ComponentName "1000 BBO Equity Load" `
    -ResultSqlDir "./Result" `
    -ResultSqlFiles "T_FILE_MONITOR.sql,T_PROCESS_MONITOR.sql,T_EXCEPTION_LOAD.sql,T_BBO_EQUITY_SEC.sql" `
    -OutputTable `
    -TestResultPath "Result.txt" `
    -CertifiedResultPath "Result.certified.txt"

# Display result & pause unless $Global:NoInput is set.
Show-Execution -Result $result -Message "Test complete!"

# Return result to calling script.
return $result
