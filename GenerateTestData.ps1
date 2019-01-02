# Load & configure deltaTest.
Invoke-Expression "$(Get-ItemPropertyValue -Path "HKCU:\Software\EnterpriseTestFoundation\deltaTest" -Name "ModuleDir")\config.ps1"

$DbServer = Read-UserEntry -Label "Database Server" -Default $EnvMedmDbServer
$DbName = Read-UserEntry -Label "Database Name" -Default $EnvMedmDbName
$TableSchema = Read-UserEntry -Label "Table Schema" -Default "dbo"
$TableName = Read-UserEntry -Label "Table Name"
$ColNamePattern = Read-UserEntry -Label "Column Name Exclusion Pattern" -Default "^CADIS_SYSTEM_" -Pattern ".*"
$CsvPath = Read-UserEntry -Label "CSV Output Path" -Pattern "\S+\.csv"
$RowCount = Read-UserEntry -Label "Row Count" -Default "10" -Pattern "-?\d+"
$MinDate = Read-UserEntry -Label "Min Date" -Default "2018-01-01T00:00:00" -Pattern "\d{4}-\d{2}-\d{2}(T\d{2}:\d{2}(:\d{2})?)?"
$MaxDate = Read-UserEntry -Label "Max Date" -Default "2027-12-31T23:59:59" -Pattern "\d{4}-\d{2}-\d{2}(T\d{2}:\d{2}(:\d{2})?)?"
$MinDec = Read-UserEntry -Label "Min Decimal" -Default "0.0" -Pattern "-?\d+(\.\d*)?"
$MaxDec = Read-UserEntry -Label "Max Decimal" -Default "10.0" -Pattern "-?\d+(\.\d*)?"
$MinInt = Read-UserEntry -Label "Min Integer" -Default "1000" -Pattern "-?\d+"
$MaxInt = Read-UserEntry -Label "Max Integer" -Default "9999" -Pattern "-?\d+"
$MaxStrLen = Read-UserEntry -Label "Max String Length" -Default "32" -Pattern "\d+"

Write-Host $("Generating test data for table [{0}].[{1}].[{2}].[{3}]..." -f $DbServer, $DbName, $TableSchema, $TableName)

Export-CsvTestData `
    -DbServer $DbServer `
    -DbName $DbName `
    -TableSchema $TableSchema `
    -TableName $TableName `
    -ColNameAction Exclude `
    -ColNamePattern $ColNamePattern `
    -CsvPath $CsvPath `
    -RowCount ([int]$RowCount) `
    -MinDate ([datetime]::ParseExact($MinDate, "yyyy-MM-ddTHH:mm:ss", $null)) `
    -MaxDate ([datetime]::ParseExact($MaxDate, "yyyy-MM-ddTHH:mm:ss", $null)) `
    -MinDec ([decimal]$MinDec) `
    -MaxDec ([decimal]$MaxDec) `
    -MinInt ([int]$MinInt) `
    -MaxInt ([int]$MaxInt) `
    -MaxStrLen ([int]$MaxStrLen)

Write-Host "Test data generation complete!"
[void](Read-Host "Press Enter to exit") 
