Add-Type -TypeDefinition @"
   public enum PatternAction
   {
      Include,
      Exclude
   }
"@

Push-Location

if (-not (Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue)) {
	Write-Host 'Invoke-Sqlcmd not loaded: loading SqlServer to fix'
	Push-Location # save the current location
	$dummy = Install-Module -Name SqlServer -ErrorAction Stop # Importing this module forces the location to a SqlServer prompt
	Pop-Location # get back to the current location, counteracting the side effect of importing SqlServer	
}

$ScriptName = $(Get-PSCallStack | Select-Object -Property * | Where-Object {$_.ScriptName -ne $null})[-1].ScriptName
$Parent = Split-Path -Path $ScriptName -Parent
$BaseName = (Get-Item $ScriptName).BaseName
Start-Transcript -Path "$($Parent)\$($BaseName).log" -Append -IncludeInvocationHeader

function Confirm-File {
    [CmdletBinding(SupportsShouldProcess = $True)]
	Param(
		[string][Parameter(Mandatory = $True)] $FilePath,
		[string][Parameter(Mandatory = $True)] $CertifiedFilePath,
		[string]$TextDiffExe = $Global:TextDiffExe,
		[string[]]$TextDiffParams = $Global:TextDiffParams,
		[string]$TestName
	)

    # Init result object.
	$result = @{
		Time = $stopWatch.Elapsed.TotalMilliseconds
		Name = $TestName
	}

    # If result file doesn't exist...
    if (-not(Test-Path $FilePath)) {
		$result.Status = "FAILED"
        $result.Reason = "Result file `"$($FilePath)`" does not exist."
    }

    # ... else if certified result file doesn't exist...
    elseif (-not(Test-Path $CertifiedFilePath)) {
		$result.Status = "FAILED"
        $result.Reason = "Certified result file `"$($CertifiedFilePath)`" does not exist."
    }

    # ... else produce result.
    else {
        # Complete result object.
		$diff = Compare-Object (Get-Content $CertifiedFilePath) (Get-Content $FilePath) -SyncWindow 1
		$result.Status = %{if (0 -eq $diff.Count -or $null -eq $diff.Count) {"PASSED"} else {"FAILED"}}

		if ($result.Status -eq "FAILED") {
			$result.Reason = ($diff | %{"$($_.SideIndicator)  $($_.InputObject)"}) -join "`r`n"

            # Visualize diff if not suppressed.
	        if (!$NoInput) {
                $params = @()
                foreach ($param in $TextDiffParams) {
                    $param = $param -replace "{{CurrentResult}}", $FilePath
                    $param = $param -replace "{{CertifiedResult}}", $CertifiedFilePath
                    $params += $param
                }

                "Displaying difference between actual & certified results." | Write-Verbose  
                if ($PSCmdlet.ShouldProcess("Text Diff")) {& $TextDiffExe $params}
                else {"`"$($TextDiffExe)`" $params" | Out-Host}
            }
		}
    }

    # Return result.
	return New-Object PSObject -Property $result
}

function Export-CsvTestData {
	Param(
        [string]$DbServer = $Global:EnvMedmDbServer,
        
        [string]$DbName = $Global:EnvMedmDbName,
        
        [string]$TableSchema = "dbo",
        
		[Parameter(Mandatory = $True)]
        [string]$TableName,

        [PatternAction]$ColNameAction = [PatternAction]::Exclude,
        
        [string]$ColNamePattern = "^CADIS_SYSTEM_|.*RUN_?ID",

        [Parameter(Mandatory = $True)]
        [string]$CsvPath,

        [int]$RowCount = 10,

        [datetime]$MinDate = [datetime]::ParseExact("2018-01-01", "yyyy-MM-dd", $null),

        [datetime]$MaxDate = [datetime]::ParseExact("2027-12-31", "yyyy-MM-dd", $null),

        [decimal]$MinDec = 0.0,

        [decimal]$MaxDec = 10.0,

        [int]$MinInt = 1000,

        [int]$MaxInt = 9999,

        [int]$MaxStrLen = 32
	)

    $Sql = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '{0}' AND TABLE_NAME = '{1}'" -f $TableSchema, $TableName

    $Columns = Invoke-Sqlcmd -ServerInstance $DbServer -Database $DbName -Query $Sql | Where { 
        (($ColNameAction -eq [PatternAction]::Exclude) -and -not($_.COLUMN_NAME -match $ColNamePattern)) `
        -or (($ColNameAction -eq [PatternAction]::Include) -and ($_.COLUMN_NAME -match $ColNamePattern)) `
    }

    If ($Columns.Count -eq 0) { Write-Host "No columns to process." }

    $Rows = @()
    For ($i = 0; $i -lt $RowCount; $i++) {
        $Row = New-Object –TypeName PSObject

        $Columns | ForEach {
            $Column = $_

            switch -Regex ($Column.DATA_TYPE) {
                "bit" { $Value = Get-Random -Minimum 0 -Maximum 2 }

                ".*char" { 
                    $StrLen = $(@($(If ($Column.CHARACTER_MAXIMUM_LENGTH -eq -1) { $MaxStrLen } Else { $Column.CHARACTER_MAXIMUM_LENGTH }), $MaxStrLen) | measure -Minimum).Minimum
                    $Value = -join((65..90) <# + (97..122) #> | Get-Random -Count $StrLen | % {[char]$_}) 
                }

                "date.*|.*time2?" { 
                    $Ticks = Get-Random -Minimum $MinDate.Ticks -Maximum ($MaxDate.Ticks + 1)
                    $Value = New-Object DateTime($Ticks)
                }

                "decimal" { $Value = Get-Random -Minimum $MinDec -Maximum $MaxDec }

                "int" { $Value = Get-Random -Minimum $MinInt -Maximum ($MaxInt + 1) }

                default { $Value = $Column.DATA_TYPE }
            }

            $Row | Add-Member -MemberType NoteProperty -Name $_.COLUMN_NAME -Value $Value
        }

        $Rows += $Row
    }

    $Rows | Export-Csv -Path $CsvPath -Encoding Unicode -NoTypeInformation
}

# Returns a list of files under a path that optionally match Regex patterns for inclusion or exclusion.
function Get-Files {
    Param(
        [string]$Path = $pwd, 
        [string[]]$Include, 
        [string[]]$Exclude
    ) 

    $files = @()

    foreach ($item in Get-ChildItem $Path)
    {
        if (Test-Path $item.FullName -PathType Container) 
        {
            Get-Files $item.FullName $include $exclude
            continue
        } 

        $leaf = Split-Path $item -Leaf
        if ($Include | Where { $leaf -inotmatch $_ }) { continue }
        if ($Exclude | Where { $leaf -imatch $_ }) { continue }
        
        $files += $item.FullName 
    } 

    return $files
}

function Import-CsvTable {
    [CmdletBinding(SupportsShouldProcess = $True)]

    Param(
        [string]$DbServer = $Global:EnvMedmDbServer,

        [string]$DbName = $Global:EnvMedmDbName,

        [Parameter(Mandatory = $True)]
        [string]$CsvPath
    )
    
    $TableName = (Get-Item $CsvPath).BaseName
    $Csv = Import-Csv -Path $CsvPath
    $Columns = $Csv[0].psobject.Properties.Name 
    $ColumnList = "[" + ($Columns -join "], [") + "]"

    $Sql = ""
    $Csv | foreach {
        $Values = $_.psobject.Properties.Value
        $ValueList = "'" + (($Values -replace "'", "''") -join "', '") + "'"

        $Sql += "INSERT {0} ({1}) VALUES ({2});`n" -f $TableName, $ColumnList, $ValueList
    }

    Invoke-Sqlcmd -ServerInstance $DbServer -Database $DbName -Query $Sql
}

function Invoke-MedmComponent {
        [CmdletBinding(SupportsShouldProcess = $True)]
	    Param(
        [string]$MedmProcessAgentPath = $Global:MedmProcessAgentPath,

        [string]$DbServer = $Global:EnvMedmDbServer,

        [string]$DbName = $Global:EnvMedmDbName,

        [string]$SetupSqlDir = $null,

        [string]$SetupSqlFiles = $null,

        [Parameter(Mandatory = $True)]
        [string]$ComponentName,

		[Parameter(Mandatory = $True)]
		[ValidateSet("DataPorter", "DataInspector", "DataMatcherProcess", "DataConstructor", "Solution")]
		[string]$ComponentType,

        [string]$ConfigurableParams = $null,

        [string]$CleanupSqlDir = $null,

        [string]$CleanupSqlFiles = $null
    )
	
	# Invoke setup scripts.
    if ($SetupSqlFiles) {
        Invoke-SqlScripts `
            -DbServer $DbServer `
            -DbName $DbName `
            -SqlDir $SetupSqlDir `
            -SqlFiles $SetupSqlFiles `
            -ScriptType "Setup Script"
    }

	# Compose MEDM component invocation.
    $params = "/server:$($DbServer) /db:$($DbName) /integrated:yes /component:$($ComponentType) /process:`"$($ComponentName)`" /usedefaultforparams:yes"
    if ($ConfigurableParams) {$params = $params + " /parameters:`"" + $ConfigurableParams.Replace(":", "`":`"").Replace("=", "`"=`"") + "`""}

	# Execute MEDM solution.
    "`nBeginning execution of MEDM $($ComponentType) `"$($ComponentName)`" on DB $($DbServer)\$($DbName)" | Write-Host  
    "`nEXECUTING $($MedmProcessAgentPath) $($params)`n" | Write-Host
    if ($PSCmdlet.ShouldProcess("MEDM $($ComponentType) $($ComponentName)")) {& $MedmProcessAgentPath $params  | Write-Host }
    "Completed execution of MEDM $($ComponentType) `"$($ComponentName)`" on DB $($DbServer)\$($DbName)`n" | Write-Host  

    # Invoke cleanup scripts.
    if ($CleanupSqlFiles) {
        Invoke-SqlScripts `
            -DbServer $DbServer `
            -DbName $DbName `
            -SqlDir $CleanupSqlDir `
            -SqlFiles $CleanupSqlFiles `
            -ScriptType "Cleanup Script"
    }

}

function Invoke-SqlScripts {
    [CmdletBinding(SupportsShouldProcess = $True)]

    Param(
        [string]$DbServer = $Global:EnvMedmDbServer,

        [string]$DbName = $Global:EnvMedmDbServer,

        [string]$SqlDir = $null,

        [string]$SqlFiles = $null,

        [string]$OutputPath = $null,

		[switch]$OutputTable,
 
        [string]$ScriptType = $Global:SqlScriptType
   )
    # Default $SqlDir to current location.
    if (-Not $SqlDir) {$SqlDir = Get-Location}
    # Iterate through $Sql list & execute each in turn.
    if ($SqlFiles) {
		"`nBeginning $($ScriptType) execution against DB $($DbServer)\$($DbName)`n" | Write-Host
        Push-Location
        if ($OutputPath) { "" | Out-File -FilePath $OutputPath }
        $SqlFiles.Split(",") | ForEach {
            Get-Files -Path $SqlDir -Include $_.Trim() | ForEach {
                $SqlPath = $_
                $SqlFile = Split-Path -Path $SqlPath -Leaf
                if ($PSCmdlet.ShouldProcess("$($ScriptType) $($SqlPath)")) {
                    $Extension = (Get-Item $SqlPath).Extension
                    if ($Extension.ToLower() -eq ".csv") {
                        "  Importing CSV File `"$($SqlFile)`"" | Write-Host

                        Import-CsvTable -DbServer $DbServer -DbName $DbName -CsvPath $SqlPath
                    }
                    else {
                        "  Executing $($ScriptType) `"$($SqlFile)`"" | Write-Host

                        if ($OutputPath) { 
                            "========== $($SqlFile) ==========" | Out-File -FilePath $OutputPath -Append 
					        if ($OutputTable) {
						        Invoke-Sqlcmd -ServerInstance $DbServer -Database $DbName -InputFile $SqlPath | Format-Table -Property * -AutoSize | Out-String -Stream -Width 32768 | Out-File -FilePath $OutputPath -Append
					        }
					        else {
						        Invoke-Sqlcmd -ServerInstance $DbServer -Database $DbName -InputFile $SqlPath | Format-List -Property * | Out-String -Stream -Width 32768 | Out-File -FilePath $OutputPath -Append
					        }
                        }
                        else { 
                            Invoke-Sqlcmd -ServerInstance $DbServer -Database $DbName -InputFile $SqlPath 
                        }
                    }
                }
            }
        }
        Pop-Location
        "`nCompleted $($ScriptType) execution against DB $($DbServer)\$($DbName)" | Write-Host
    }
}

function Publish-Results {
	Param(
		[string]$ReportFolder = $Global:ReportFolder,
		[Parameter(Mandatory = $True)]
		[string]$TestSuiteName,
		[Parameter(Mandatory = $True)]
		[Object[]]$Results,
		[ValidateSet("JUnit")]
		[string]$ReportFormat = "JUnit"
	)

	if ($ReportFormat -eq "JUnit") {
		$template = @'
<testsuite name="" tests="" failures="" timestamp="" time="" package="deltaTest">
<testcase classname="" name="" time="">
    <failure type="" message=""/>
</testcase>
</testsuite>
'@

		# load XML template 
		$xml = New-Object xml		
		$xml.LoadXml($template)
		$newTestCaseTemplate = (@($xml.testsuite.testcase)[0]).Clone()  

		# populate suite-level attributes
		$xml.testsuite.name = $TestSuiteName
		$xml.testsuite.tests = $Results.Count.ToString()
		$xml.testsuite.timestamp = (Get-Date -Format u).ToString()
		$totalTime = ($Results | Measure-Object -Property Time -Sum).Sum
		$xml.testsuite.time = "{0:c}" -f ([TimeSpan]::FromMilliseconds($totalTime))
		$xml.testsuite.failures = ($Results | Where-Object {$_.Status -eq "FAILED"} | Measure-Object).Count.ToString()

		# populate test-level attributes
		foreach($result in $Results) 
		{   
		    $newTestCase = $newTestCaseTemplate.clone()
		    $newTestCase.classname = $TestSuiteName

			$newTestCase.name = $result.Name.ToString()
			$newTestCase.time = "{0:c}" -f ([TimeSpan]::FromMilliseconds($result.Time))


		    if($result.Status -eq "PASSED")
		    {   #Remove the failure node, since this is a success
		        $newTestCase.RemoveChild($newTestCase.failure) | Out-Null
		    }
		    else
		    {
				$newTestCase.failure.type = "deltaTest.Fail"
				#$newTestCase.failure.InnerText = Format-ErrorRecord $result.Reason
		        $newTestCase.failure.message = $result.Reason 
		    }
		    $xml.testsuite.AppendChild($newTestCase) > $null
		}   

		# remove test case template
		$xml.testsuite.testcase | Where-Object { $_.Name -eq "" } | ForEach-Object  { [void]$xml.testsuite.RemoveChild($_) }

		# save xml to file
		if(!(Test-Path -Path $ReportFolder )){
			New-Item -ItemType directory -Path $ReportFolder # ensure folder exists
		}
		$path = "$($ReportFolder)\$($TestSuiteName)_junit_results.xml"
		$originalPath = $path
		$i = 0;
		while (Test-Path $path) {
			$i++
			$extension = $originalPath.Split(".")[-1];
			$path = $originalPath.Replace(".$($extension)", "_$($i).$($extension)") # don't overwrite any earlier files that were part of the same Test Suite; instead make it Filename_1.xml, Filename_2.xml, etc
		}
		$xml.Save($path)

		return $path
	}
}

function Read-UserEntry {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Label,

        [string]$Default,

        [string]$Pattern = ".+"
    )

    while (!$Result) {
        Write-Host ("`n" + $Label.ToUpper())
        Write-Host "Pattern: $Pattern"
        If ($Default) { 
            Write-Host "Default: $Default"
            If (($Result = Read-Host "New value or Enter to accept default") -eq "") { $Result = $Default }
        }
        Else { $Result = Read-Host "Enter value" }

        If ($Result -inotmatch $Pattern) {
            Write-Host "Failed pattern match!" -ForegroundColor Magenta
            $Result = $null
            continue
        }

        Write-Host ($Label + ": ") -NoNewline
        Write-Host $Result -ForegroundColor Yellow
    }

    return $Result
}

function Show-Execution {
    Param(
        [PSObject]$Result,

        [string]$Message = ""
    )

    If ($Message) { "`n$($Message)" | Out-Host }

    If ($Result) { $Result | Out-Host }

    If ($NoInput) { return }

    [void](Read-Host "Press Enter to continue") 
}

function Test-Installed( $program ) {
    
    $x86 = ((Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -like "*$program*" } ).Length -gt 0;

    $x64 = ((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -like "*$program*" } ).Length -gt 0;

    return $x86 -or $x64;
}

function Test-MedmComponent {
    [CmdletBinding(SupportsShouldProcess = $True)]

    Param(
        [string]$MedmProcessAgentPath = $Global:MedmProcessAgentPath,

		[string]$DbServer = $Global:EnvMedmDbServer,

		[string]$DbName = $Global:EnvMedmDbName,

		[string]$SetupSqlDir = $null,

		[string]$SetupSqlFiles = $null,

		[Parameter(Mandatory = $True)]
        [string]$ComponentName,

		[Parameter(Mandatory = $True)]
		[ValidateSet("DataPorter", "DataInspector", "DataMatcherProcess", "DataConstructor", "Solution")]
		[string]$ComponentType,

		[string]$ConfigurableParams = $null,

		[string]$ResultSqlDir = $null,

        [string]$ResultSqlFiles = $null,

		[string]$CleanupSqlDir = $null,

		[string]$CleanupSqlFiles = $null,

		[Parameter(Mandatory = $True)]
        [string]$TestResultPath,

		[string]$CertifiedResultPath = $null,

		[string]$TextDiffExe = $Global:TextDiffExe,

		[string[]]$TextDiffParams = $Global:TextDiffParams,

		[switch]$OutputTable,

		[string]$TestName,

		[switch]$SkipProcess
    )
	$stopWatch = [Diagnostics.Stopwatch]::StartNew()

    # Invoke setup scripts and MEDM component.
    if (-not($SkipProcess)) {
        Invoke-MedmComponent `
            -MedmProcessAgentPath $MedmProcessAgentPath `
            -DbServer $DbServer `
            -DbName $DbName `
		    -ComponentType $ComponentType `
            -ComponentName $ComponentName `
            -ConfigurableParams $ConfigurableParams `
            -SetupSqlDir $SetupSqlDir `
            -SetupSqlFiles $SetupSqlFiles
    }

    # Invoke result scripts.
	if ($ResultSqlFiles) {
		Invoke-SqlScripts `
			-DbServer $DbServer `
			-DbName $DbName `
			-SqlDir $ResultSqlDir `
			-SqlFiles $ResultSqlFiles `
			-ScriptType "Result Query" `
			-OutputPath $TestResultPath `
			-OutputTable:$OutputTable
	}

    # Invoke cleanup scripts.
    if (-not($SkipProcess)) {
        if ($CleanupSqlFiles) {
            Invoke-SqlScripts `
                -DbServer $DbServer `
                -DbName $DbName `
                -SqlDir $CleanupSqlDir `
                -SqlFiles $CleanupSqlFiles `
                -ScriptType "Cleanup Script"
        }
    }

	$stopWatch.Stop()
	
	$result = Confirm-File `
		-FilePath $TestResultPath `
		-CertifiedFilePath $CertifiedResultPath `
		-TestName $TestName `
		-TextDiffExe $TextDiffExe `
		-TextDiffParams $TextDiffParams

	return $result
}

Pop-Location
