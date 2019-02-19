# Welcome to deltaTest!

**deltaTest** is an open-source, PowerShell-based testing framework. It is designed to automate the testing of complex systems (like [Enterprise Data Management](https://en.wikipedia.org/wiki/Enterprise_data_management) systems) that normally resist efficient test automation.

**deltaTest** currently supports the [Markit Enterprise Data Management](https://ihsmarkit.com/products/edm.html) platform, but can easily be adapted to support testing of any platform of any kind that meets the following prerequisites:

* It can be invoked from the Windows command line.
* It can be induced to produce test output either via a text file or a query against a SQL Server database.

Other features:

* Tests are expressed as short PowerShell scripts, which live in your version control repository and travel with your code. 
* Tests can be shared and executed across an entire development team and in multiple environments.
* Test results are output as simple text files. Once a test result is *certified*, any difference against the certified result indicates a test failure.
* Test failure optionally invokes a text comparison engine ([WinMerge](http://winmerge.org/), by default) to visualize the diff as a *very* useful troubleshooting aid.
* Tests can be invoked from other scripts and test results can be piped to other processes to support automated regression testing and continuous delivery.

# Table of Contents

- [deltaTest in a Nutshell](#deltatest-in-a-nutshell)
- [Getting Started](#getting-started)
  * [Potential Installation Issues](#potential-installation-issues)
    + [Local Execution Policy](#local-execution-policy)
    + [SQL Server Module](#sql-server-module)
    + [Markit EDM](#markit-edm)
    + [WinMerge](#winmerge)
    + [Changing Environments](#changing-environments)
- [Key Files and Directories](#key-files-and-directories)
- [Global Variables](#global-variables)
- [Cmdlets](#cmdlets)
  * [Confirm-File](#confirm-file)
  * [Export-CsvTestData](#export-csvtestdata)
  * [Import-CsvTable](#import-csvtable)
  * [Invoke-MedmComponent](#invoke-medmcomponent)
  * [Invoke-SqlScripts](#invoke-sqlscripts)
  * [Publish-Results](#publish-results)
  * [Read-UserEntry](#read-userentry)
  * [Show-Execution](#show-execution)
  * [Test-MedmComponent](#test-medmcomponent)
- [Scripts](#scripts)
  * [cert.ps1](#certps1)
  * [GenerateTestData.ps1](#generatetestdataps1)
  * [runall.ps1](#runallps1)
- [Database Objects](#database-objects)
  * [dbo.tvf_Core_Rows](#dbotvf-core-rows)
  * [dbo.tvf_Core_Split_Delimiter](#dbotvf-core-split-delimiter)
  * [dbo.usp_Core_DumpData](#dbousp-core-dumpdata)

# deltaTest in a Nutshell

[![IMAGE ALT TEXT](http://img.youtube.com/vi/IZcik7VR1ZI/0.jpg)](http://www.youtube.com/watch?v=IZcik7VR1ZI "deltaTest in a Nutshell")

_Click to watch the video, or click [here](https://github.com/enterprise-test-foundation/delta-test/wiki/deltaTest-in-a-Nutshell) for a transcript._

# Getting Started

First thing is to get deltaTest installed. If it is already in use in your organization, some of this may already be done. Do that parts that are not.

1. Clone this repository into a shared directory that is accessible to your whole development team.
1. Copy script *config_template.ps1* to *config.ps1* and configure it with relevant environment settings.
1. Run the scripts in the [*DB*](https://github.com/EnterpriseDataFoundation/deltaTest/tree/master/DB) directory in the order indicated, in every DB environment where you will be performing tests. If the object names don't work with your DB object naming convention, you can change them as long as you propagate the changes through the code. Note that the *Dump_Data* stored procedure will be called by most of your test result scripts, so be sure to propagate any changes there as well!
1. Copy the [*Test*](https://github.com/EnterpriseDataFoundation/deltaTest/tree/master/Test) directory into an appropriate location in your version control system. Best guidance is that your tests should live right alongside your code, because they ARE code!
1. From the [*Install*](https://github.com/EnterpriseDataFoundation/deltaTest/tree/master/Install) directory, run the +INSTALL shortcut, accepting all defaults.

Now you are ready to run a test!

1. Clone a code repository containing tests to your local machine and find the *Test* directory. Navigate into one of the test folders and open a test script: it should be obvious what is going to be tested. Now right-click on the test script file and select *Run with  PowerShell*. 
1. Once text execution completes, find file *Result.txt* in the test directory. Open the file and scrutinize the test result. Is it what it should be?
1. If the test result is correct, open the main **deltaTest** repository and drag and drop your *Result.txt* file onto the *CERTIFY* shortcut you find there. The invoked PowerShell script will copy your *Result.txt* file into *Result.certified.txt* in the same location. 
1. Now make a code change to the process under test and run the test again. If the newly generated *Result.txt* file differs from the certified version in any way, an instance of WinMerge will open, displaying the files side-by-side, so you can visualize the diff and zero in on precisely what broke.
1. If the code change and new result are desirable, certify the new results file. This becomes the baseline for future tests.
1. Check any changes into your version control system so that the next developer to exercise this code can stand on your shoulders!

If you run into any issues the first time through, see the sections below. 

[Back to Top](#welcome-to-deltatest)

## Potential Installation Issues

The **+INSTALL** script configures the local system and writes local configurations to the Windows Registry. So long as the user has local admin privileges, this script should self-elevate and just work. In case it does not, check the items below and then run the installation script again.

### Local Execution Policy

All **deltaTest** tests are articulated as PowerShell scripts. The first time you run a PowerShell script on your machine, you may get an error indicating that the execution of scripts is disabled on your system. If this occurs, open a PowerShell command prompt *as administrator* and run the following command:

```powershell
Set-ExecutionPolicy Unrestricted -Force
```

Click [here](https://www.mssqltips.com/sqlservertip/2702/setting-the-powershell-execution-policy) for more info on setting your local execution policy.

Note also that there is also an issue around the network location from which a script is run. Scripts that are run from an internet location, as opposed to a LAN location, raise special alerts. If your network location can be expressed either way (i.e. `//domain/resources/...` vs `//domain.com/resources/...`, choose the LAN version to minimize security alerts.

[Back to Top](#welcome-to-deltatest)

### SQL Server Module

The first time you execute a test, **deltaTest** may attempt to download and install the *SqlServer* PowerShell module. If this occurs, you will see prompts requesting permission to run NuGet. Grant the requested permissions. 

If this process breaks and you see errors indicating that the module is not connecting to SQL Server, open a PowerShell command prompt *as administrator* and run the following command:

```powershell
Install-Module -Name SqlServer -Force
```

[Back to Top](#welcome-to-deltatest)

### Markit EDM

By default, **deltaTest** is expecting Markit EDM (MEDM) v17.1.132.0 to be installed in the default installation directory on your local machine. If you are running a different version of MEDM, or from a different directory, indicate the Process Agent Path when you run the **+INSTALL** script:

![MedmProcessAgentPath](Doc/MedmProcessAgentPath.PNG)

[Back to Top](#welcome-to-deltatest)

### WinMerge

**deltaTest** uses [WinMerge](http://winmerge.org) as its text comparison engine. If WinMerge is not installed, the **+INSTALL** script will install it unless the **-NoInput** optuion is enabled.

**deltaTest** expects WinMerge to reside in its default installation directory. Using an alternate text comparison engine or a non-default installation directory are provided for but are not currently enabled. 

[Back to Top](#welcome-to-deltatest)

### Changing Environments

Environment-specific tokens and values are managed centrally in script *config.ps1*. The active testing environment is stored in the Windows Registry.

To switch to a different testing environment, run the **+INSTALL** script and designate a different Active Environment token, like this:

![ActiveEnvironment](Doc/ActiveEnvironment.PNG)

[Back to Top](#welcome-to-deltatest)

# Key Files and Directories

**+CERTIFY shortcut** &ndash; Drop a result file on this shortcut to certify it.

**+RUNALL shortcut** &ndash; Drop a directory on this shortcut execute all PowerShell scripts inside it.

**cert.ps1** &ndash; Target of the +CERTIFY shortcut. Copies file *abc.xyz* to file *abc.certfied.xyz*.

**GenerateTestData.ps1** &ndash; Generates a CSV file of random test data based on a DB table schema.

**deltaTest.psm1** &ndash; deltaTest PowerShell module.

**runall.ps1** &ndash; Target of the +RUNALL shortcut. Recursively executes all .PS1 scripts within a directory.

**config_template.ps1** &ndash; Should be copied and maintained as *config.ps1*. Central repository for shared and environment-specific configurations.

**DB directory** &ndash; Database objects to be installed in every environment to be tested.

**Install directory** &ndash; Local installation script & artifacts.

* **+INSTALL shortcut** &ndash; Double-click this shortcut to install & configure **deltaTest** on your local machine. *You must have local admin privileges to do this!*
* **install.ps1** &ndash; Target of the +INSTALL shortcut. Configures local system & sets local config.
* **WinMerge-2.14.0-Setup.exe** &ndash; WinMerge installer.

**Test directory** &ndash; Sample test repository. Copy this into source control and use it as a starting point.

[Back to Top](#welcome-to-deltatest)

# Global Variables

The deltaTest module creates a number of global variables, whose default values are set directly in *deltaTest.psm1*. 

A number of scenarios require these values to be overridden at the local level, for example so that one developer might run his tests in environment other than DEV.

Environment tokens and environment-specific global variables are centrally managed in *config.ps1*. To select an active testing environment, run the **+INSTALL** script and specify a valid environment token.

To create a new global variable, simply add it to *config.ps1*. 

| Global Variable | Description | Default Value |
|:--|:--|:--|
| ActiveEnvironment | Sets the environment against which tests will be executed. Leverages shared script *config.ps1* to set relevant global variables. | `"DEV"` |
| MedmProcessAgentPath | The local path to the MEDM Process Agent executable. This path will vary based on the MEDM version in use. Should be consistent across the team. | `"C:\Program Files\Markit Group\Markit EDM_17_1_132_0\CadisProcessAgent.exe"`|
| MedmDbServer | The SQL Server of the MEDM environment against which the test will execute. | `"DbServer"` |
| MedmDbName | The SQL Server database name of the MEDM environment against which the test will execute. | `"DbName"` |
| TextDiffExe | The local path to your text comparison engine's executable (WinMerge by default). | `"C:\Program Files (x86)\WinMerge\WinMergeU.exe"` |
| TextDiffParams | An array of strings representing the text comparison engine's command-line parameters. Tokens `{CurrentResult}` and `{CertfiedResult}` will be replaced by the relevant file names. | `@("/e", "/s", "/u", "/wl", "/wr", "/dl", "Current Result", "/dr", "Certified Result", "{CurrentResult}", "{CertifiedResult}"`) |
| SuppressTextDiffPopup | When `$true`, this switch prevents the text comparison engine from being invoked in the event of a failed test. Useful for automated regression testing. | `$false` |
| SqlScriptType | The script type token to use when `-Verbose` or `-WhatIf` are activated. Useful for troubleshooting. | `"Sql Script"` |
| ReportFolder | The default location where *Publish-Results* will place test results reports. | `"C:\deltaTest\Results"` |

[Back to Top](#welcome-to-deltatest)

# Cmdlets

deltaTest features the following cmdlets. Most are used internally, but any may be used in your test scripts or elsewhere.

[Back to Top](#welcome-to-deltatest)

## Confirm-File

Performs file validation. Pops up the diff tool on completion, and writes out test results in JUnit format. *Confirm-File* is useful in the case where you have multiple files output by the process under test. You can call *Invoke-MedmComponent* and then call *Confirm-File* multiple times (once per file output from the process). 

Internally, *Test-MedmComponent* calls *Confirm-File* to validate the test results with a certified file. 

**Syntax**

```powershell
Confirm-File `
	-FilePath <string> `
	-CertifiedFilePath <string> `
	[-SuppressTextDiffPopup] `
	[-TextDiffExe <string>] `
	[-TextDiffParams <string[]>] `
	[-TestName <string>]
```
**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -FilePath | Required. Current test result file. Relative paths will be resolved relative to the current directory.<br /><br />Ex: `-FilePath "Result.txt"` |
| -CertifiedFilePath | Required. Certified test result file. Relative paths will be resolved relative to the current directory.<br /><br />Ex: `-CertifiedFilePath "Result.certified.txt"` |
| -TextDiffExe | Optional. The local path to your text comparison engine's executable (WinMerge by default). Defaults to the value of `$Global:TextDiffExe`.<br /><br />Ex:`-TextDiffExe "C:\Program Files (x86)\WinMerge\WinMergeU.exe"` |
| -TextDiffParams | Optional. An array of strings representing the text comparison engine's command-line parameters. Tokens `{CurrentResult}` and `{CertfiedResult}` will be replaced by the relevant file names. Defaults to the value of `$Global:TextDiffParams`. <br /><br />Ex: `-TextDiffParams @("/e", "/s", "/u", "/wl", "/wr", "/dl", "Current Result", "/dr", "Certified Result", "{CurrentResult}", "{CertifiedResult}"`) |

[Back to Top](#welcome-to-deltatest)

## Export-CsvTestData

Generates a CSV file of random test data matching the schema of a designated database table.

Columns may be included or excluded based on a regex pattern. Values may be constrained into ranges by type.

Character data will be generated as random sequences of capital letters, to the column length limit or to the value of *-MaxStrLen*, whichever is smaller.

**Syntax**

```powershell
Export-CsvTestData `
    [-DbServer <string>] `
    [-DbName <string>] `
    [-TableSchema <string>] `
    -TableName <string> `
    [-ColNameAction <Include|Exclude>] `
    [-ColNamePattern <string>] `
    -CsvPath <string>] `
    [-RowCount <int>] `
    [-MinDate <datetime>] `
    [-MaxDate <datetime>] `
    [-MinDec <decimal>] `
    [-MaxDec <decimal>] `
    [-MinInt <int>] `
    [-MaxInt <int>] `
    [-MaxStrLen <int>]
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -DbServer | Optional. The target SQL Server database server address. Defaults to the value of `$Global:MedmDbServer`.<br /><br />Ex: `-DbServer "MyDbServer"` |
| -DbName   | Optional. The target SQL Server database name. Defaults to the value of `$Global:MedmDbName`.<br /><br />Ex: `-DbName "MyDb"` |
| -TableSchema | Optional. Schema of the target database table. Defaults to "dbo".<br /><br />Ex: `-TableSchema "dbo"` |
| -TableName | Required. Target database table name.<br /><br />Ex: `-TableName "T_MASTER_SEC"` |
| -ColNameAction | Optional. Indicates whether *-ColNamePattern* will be used to include or exclude columns. Defaults to *Exclude*.<br /><br />Ex: `-ColNameAction Exclude` |
| -ColNamePattern | Optional. Regex pattern of column names to include or exclude. Defaults to "^CADIS_SYSTEM\_\|.\*RUN\_?ID".<br /><br />Ex: `-ColNamePattern "^CADIS_SYSTEM\_.\*RUN\_?ID"` |
| -CsvPath  | Required. The path to the CSV file to be generated. Relative paths will be resolved relative to the script execution patrh.<br /><br />Ex: `-CsvPath "./SetupSql/T_MASTER_SEC.csv"` |
| -RowCount | Optional. Number of rows of test data to generate. Defaults to 10.<br /><br />Ex: `-RowCount 10` |
| -MinDate | Optional. Minimum value for randomly generated date-type values. Defaults to 2018-01-01T00:00:00.<br /><br />Ex: `-MinDate [datetime]::ParseExact("2018-01-01", "yyyy-MM-dd", $null)` |
| -MaxDate | Optional. Maximum value for randomly generated date-type values. Defaults to 2028-01-01T00:00:00.<br /><br />Ex: `-MaxDate [datetime]::ParseExact("2028-01-01", "yyyy-MM-dd", $null)` |
| -MinDec | Optional. Minimum value for randomly generated decimal-type values. Defaults to 0.0.<br /><br />Ex: `-MinDec 0.0` |
| -MaxDec | Optional. Maximum value for randomly generated decimal-type values. Defaults to 10.0.<br /><br />Ex: `-MaxDec 10.0` |
| -MinInt | Optional. Minimum value for randomly generated integer-type values. Defaults to 0.<br /><br />Ex: `-MinInt 0.0` |
| -MaxInt | Optional. Maximum value for randomly generated integer-type values. Defaults to 10.<br /><br />Ex: `-MaxInt 10.0` |
| -MaxStrLen | Optional. Maximum length of generated character strings. Defaults to 32.<br /><br />Ex: `-MaxStrLen 32` |

[Back to Top](#welcome-to-deltatest)

## Import-CsvTable

Converts a CSV file into a set of SQL insert statements and executes them against a database as follows:

* The table name will be the file name, excluding the CSV extension. If the table is in a non-default schema, add the schema name to the file name, like this: `myschema.MYTABLE.csv`.
* The column names will be drawn from the first row of the CSV file. Column names will be enclosed in square brackets, so odd column names are still valid.
* All values will be inserted as text, with any single quotes escaped. The system relies on implicit conversion to the table column's native type.
* The system performs no checking around nonexistent column names, invalid types, primary key collisions, etc. Any of these will produce a SQL error. *Caveat emptor.*

**Syntax**

```powershell
Import-CsvTable `
    [-DbServer <string>] `
    [-DbName <string>] `
    -CsvPath <string> 
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -DbServer | Optional. The target SQL Server database server address. Defaults to the value of `$Global:MedmDbServer`.<br /><br />Ex: `-DbServer "MyDbServer"` |
| -DbName   | Optional. The target SQL Server database name. Defaults to the value of `$Global:MedmDbName`.<br /><br />Ex: `-DbName "MyDb"` |
| -CsvPath  | Required. The path to the CSV file to be loaded. Relative paths will be resolved relative to the script execution patrh.<br /><br />Ex: `-CsvPath "./SetupSql/T_MASTER_SEC.csv"` |

[Back to Top](#welcome-to-deltatest)

## Invoke-MedmComponent

Executes a Markit EDM Component. Optionally executes a set of SQL setup scripts prior to Component execution, and a set of cleanup scripts after Component execution.

**Syntax**

```powershell
Invoke-MedmComponent `
    [-ProcessAgentPath <string>] `
    [-DbServer <string>] `
    [-DbName <string>] `
    [-SetupSqlDir <string>] `
    [-SetupSqlFiles <string>] `
    -ComponentName <string>] `
    -ComponentType <string>] `
    [-ConfigurableParams <string>] `
    [-CleanupSqlDir <string>] `
    [-CleanupSqlFiles <string>] `
```
**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -ProcessAgentPath | Optional. Path to command line executable for target MEDM version. Defaults to the value of `$Global:MedmProcessAgentPath`. <br /><br />Ex: `-ProcessAgentPath "C:\Program Files\Markit Group\Markit EDM_10_5_3_1\CadisProcessAgent.exe"` |
| -DbServer | Optional. The target SQL Server database server address. s to the value of `$Global:MedmDbServer`. <br /><br />Ex: `-DbServer "DbServer"` |
| -DbName | Optional. The target SQL Server database name. Defaults to the value of `$Global:MedmDbName`.<br /><br />Ex: `-DbName "DbName"` |
| -SetupSqlDir | Optional. A directory containing SQL scripts to be executed prior to component invocation. Relative paths will be resolved relative to the current directory. If omitted, defaults to the current directory. <br /><br />Ex: `-SetupSqlDir ".\SetupSql"` |
| -SetupSqlFiles | Optional. A comma-delimited list of RegEx patterns indicating SQL script files to be executed and/or CSV data files to be imported. All files must be nested within the directory indicated by `-SetUpSqlDir`. Defaults to `".+\.(?:sql|csv)"`.<br /><br />Ex: `-SetupSqlFiles "T_PREMASTER_SEC\.sql,.*\.csv"` |
| -ComponentName | Required. The name of the MEDM component to be executed. <br /><br />Ex: `-ComponentName "My Solution"` |
| -ComponentType | Required. The type of the MEDM component to be executed. One of the following values: DataPorter, DataInspector, DataMatcherProcess, DataConstructor, Solution.<br /><br />Ex: `-ComponentType: "Solution"` |
| -ConfigurableParams | Optional. A delimited list of MEDM configurable parameter name=value pairs. Pairs are delimited with a ":". Only include parameters that must be explicitly set; those retaining default values may be omitted. Parameter names and values must not contain characters "=" or ":". <br /><br />Ex: `-SolutionParams "param1=value1:param2=value2"` |
| -CleanupSqlDir | Optional. A directory containing SQL scripts to be executed following component invocation. Relative paths will be resolved relative to the current directory. If omitted, defaults to the current directory. <br /><br />Ex: `-CleanupSqlDir ".\CleanupSql"` |
| -CleanupSqlFiles | Optional. A comma-delimited list of RegEx patterns indicating SQL script files to be executed following component invocation. All must be nested within the directory indicated by `-CleanupSqlDir`. Defaults to `".+\.(?:sql|csv)"` <br /><br />Ex: `-CleanupSqlFiles "MyCleanupSqlFile1\.sql,MyCleanupSqlFile2\.sql"` |

[Back to Top](#welcome-to-deltatest)

## Invoke-SqlScripts

Executes an ordered list of SQL scripts located in the same directory. Optionally collects their outputs into a text file.

If a file in the list has a .CSV extension, then it will be executed as a set of INSERT statements with the as described in the *Import-CsvTable* cmdlet documentation above.

**Syntax**

```powershell
Invoke-SqlScripts `
    [-DbServer <string>] `
    [-DbName <string>] `
    [-SqlDir <string>] `
    [-SqlFiles <string>] `
    [-OutputPath <string>] `
    [-OutputTable] `
    [-ScriptType <string>]
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -DbServer | Optional. The target SQL Server database server address. Defaults to the value of `$Global:MedmDbServer`.<br /><br />Ex: `-DbServer "DbServer"` |
| -DbName   | Optional. The target SQL Server database name. Defaults to the value of `$Global:MedmDbName`.<br /><br />Ex: `-DbName "MyDb"` |
| -SqlDir   | Optional. The directory containing the SQL scripts to be executed. Relative paths will be resolved relative to the current directory. If omitted, defaults to the current directory.<br /><br />Ex: `-SqlDir "./ResultSql"` |
| -SqlFiles | Optional. A comma-delimited list of RegEx patterns indicating SQL script files to be executed and/or CSV data files to be imported. All files must be nested within the directory indicated by `-SqlDir`. Defaults to `".+\.(?:sql|csv)"`.<br /><br />Ex: `-SqlFiles "T_PREMASTER_SEC\.sql,.*\.csv"` |
| -OutputPath | Optional. If set, indicates the single text file to which all script outputs will be written. Relative paths will be resolved relative to the current directory. File will be overwritten if it exists. <br /><br />Ex: `-OutputPath "Result.txt"` |
| -OutputTable | Switch. If present, causes output data to be formatted as a table. Otherwise output data is formatted as a list. <br /><br />Ex: `-OutputTable` |
| -ScriptType | Optional. Differentiates different script types in conjunction with the `-Verbose` and `-WhatIf` switches. Defaults to the value of `$Global:SqlScriptType`. <br /><br />Ex: `-ScriptType "Sql Script"` |

[Back to Top](#welcome-to-deltatest)

## Publish-Results

Produces a report showing pass/fail status of tests in a standard test results reporting format. Currently supports JUnit.

**Syntax**

```
Publish-Results `
    [-ReportFolder <string>] `
    -TestSuiteName <string> `
    -Results <Object[]> `
    [-ReportFormat <string>]
```
**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -ReportFolder | Optional. Points to the folder that should contain the generated report. If omitted, defaults to `$Global:ReportFolder`.<br /><br />Ex: `-ReportFolder "C:\deltaTest\Results"` |
| -TestSuiteName | Required. The name of the test suite. Can be whatever string value you choose.<br /><br />Ex: `-TestSuiteName "Load Tests"` |
| -Results | Required. An array containing test results objects returned from calls to `Test-MedmComponent`. <br /><br />Ex: `-Results $MyResults` |
| -ReportFormat | Optional. The desired report format. Defaults to `"JUnit"`.<br /><br />Ex: `-ReportFormat "JUnit"` |

**Returns**

A string value containing the path to the report file.

[Back to Top](#welcome-to-deltatest)

## Read-UserEntry

This is a utility cmdlet that captures input from the user and validates it against a regex pattern. If a default value is provided, the user can accept it by pressing Enter.

**Syntax**

```powershell
Read-UserEntry `
	-Label <string> `
	[-Default <string>] `
	[-Pattern <string>]
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -Label | Required. Identifies the data being captured to the user.<br /><br />Ex: `-Label "Height Above Sea Level"` |
| -Default | Optional. Default value, which the user can accept by pressing the Enter key.<br /><br />Ex: `-Default "0"` |
| -Pattern | Optional. Regex pattern against user input will be evaluated. Defaults to ".\*" <br /><br />Ex: `-Pattern "\d+"` |

[Back to Top](#welcome-to-deltatest)

## Show-Execution

Displays test execution output and optionally pauses for a user keypress.

**Syntax**

```powershell
Read-UserEntry `
	-Result <PSObject> `
	[-Message <string>]
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -Result | Test result object.<br /><br />Ex: `-Result $result ` |
| -Message | Optional. Message to be displayed following test execution.<br /><br />Ex: `-Message "Test complete!" ` |

[Back to Top](#welcome-to-deltatest)

## Test-MedmComponent

Tests a Markit EDM component by performing the following actions:

* Optionally execute a set of setup scripts. 
* Executing the component.
* Execute a set of result scripts and consolidate their outputs into a text file.
* Optionally execute a set of cleanup scripts.
* Performing a comparison of the new result file against a certified result.
* If a difference exists, optionally invoke a text comparison engine to visualize it.
* Return a test result object.

**Syntax**

```powershell
Test-MedmComponent `
    [-ProcessAgentPath <string>] `
    [-DbServer <string>] `
    [-DbName <string>] `
    [-SetupSqlDir <string>] `
    [-SetupSqlFiles <string>] `
    -ComponentName <string> `
    -ComponentType <string> `
    [-ConfigurableParams <string>] `
    [-ResultSqlDir <string>] `
    [-ResultSqlFiles <string>] `
    [-OutputTable] `
    [-CleanupSqlDir <string>] `
    [-CleanupSqlFiles <string>] `
    [-TestResultPath <string>] `
    [-CertifiedResultPath <string>] `
    [-SuppressDiffToolPopup] `
    [-TextDiffExe <string>] `
    [-TextDiffParams <string[]>] `
    [-TestName <string>]
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -ProcessAgentPath | Optional. Path to command line executable for target MEDM version. Defaults to the value of `$Global:MedmProcessAgentPath`. <br /><br />Ex: `-ProcessAgentPath "C:\Program Files\Markit Group\Markit EDM_10_5_3_1\CadisProcessAgent.exe"` |
| -DbServer | Optional. The target SQL Server database server address. Defaults to the value of `$Global:MedmDbServer`. <br /><br />Ex: `-DbServer "DbServer"` |
| -DbName | Optional. The target SQL Server database name. Defaults to the value of `$Global:MedmDbName`.<br /><br />Ex: `-DbName "DbName"` |
| -SetupSqlDir | Optional. A directory containing SQL scripts to be executed prior to component invocation. Relative paths will be resolved relative to the current directory. If omitted, defaults to the current directory. <br /><br />Ex: `-SetupSqlDir ".\SetupSql"` |
| -SetupSqlFiles | Optional. A comma-delimited list of RegEx patterns indicating SQL script files to be executed and/or CSV data files to be imported. All files must be nested within the directory indicated by `-SetUpSqlDir`. Defaults to `".+\.(?:sql|csv)"` <br /><br />Ex: `-SetupSqlFiles "T_PREMASTER_SEC\.sql,.*\.csv"` |
| -ComponentName | Required. The name of the MEDM component to be executed. <br /><br />Ex: `-ComponentName "My Solution"` |
| -ComponentType | Required. The type of the MEDM component to be executed. One of the following values: DataPorter, DataInspector, DataMatcherProcess, DataConstructor, Solution.<br /><br />Ex: `-ComponentType: "Solution"` |
| -ConfigurableParams | Optional. A delimited list of MEDM configurable parameter name=value pairs. Pairs are delimited with a ":". Only include parameters that must be explicitly set; those retaining default values may be omitted. Parameter names and values must not contain characters "=" or ":". |
| -ResultSqlDir | Optional. A directory containing SQL scripts to extract test results after component execution. Relative paths will be resolved relative to the current directory. If omitted, defaults to the current directory. <br /><br />Ex: `-ResultSqlDir ".\ResultSql"` |
| -ResultSqlFiles | Optional. A comma-delimited list of RegEx patterns indicating SQL script files to extract test results after component execution. All must be located within the directory indicated by `-ResultSqlDir`. Defaults to `".+\.(?:sql|csv)"` <br /><br />Ex: `-ResultSqlFiles ".*"` |
| -OutputTable | Switch. If present, causes output data to be formatted as a table. Otherwise output data is formatted as a list. <br /><br />Ex: `-OutputTable` |
| -CleanupSqlDir | Optional. A directory containing SQL scripts to be executed following component invocation. Relative paths will be resolved relative to the current directory. If omitted, defaults to the current directory. <br /><br />Ex: `-CleanupSqlDir ".\CleanupSql"` |
| -CleanupSqlFiles | Optional. A comma-delimited list of RegEx patterns indicating SQL script files to be executed following component invocation. All must be nested within the directory indicated by `-CleanupSqlDir`. Defaults to `".+\.(?:sql|csv)"` <br /><br />Ex: `-CleanupSqlFiles "MyCleanupSqlFile1\.sql,MyCleanupSqlFile2\.sql"` |
| -TestResultPath | Required. Destination file for test result scripts. Relative paths will be resolved relative to the current directory, and any existing file of the same name will be overwritten.<br /><br />Ex: `-TestResultPath "Result.txt"` |
| -CertifiedResultPath | Required. Certified test result file. Relative paths will be resolved relative to the current directory.<br /><br />Ex: `-CertifiedFilePath "Result.certified.txt"` |
| -SuppressTextDiffPopup | Switch. If present, prevents the text comparison engine from being invoked in the event of a failed test. Useful for automated regression testing. Defaults to the value of `$Global:SuppressTextDiffPopup`.<br /><br />Ex: `-SuppressTextDiffPopup` |
| -TextDiffExe | Optional. The local path to your text comparison engine's executable (WinMerge by default). Defaults to the value of `$Global:TextDiffExe`.<br /><br />Ex:`-TextDiffExe "C:\Program Files (x86)\WinMerge\WinMergeU.exe"` |
| -TextDiffParams | Optional. An array of strings representing the text comparison engine's command-line parameters. Tokens `{CurrentResult}` and `{CertfiedResult}` will be replaced by the relevant file names. Defaults to the value of `$Global:TextDiffParams`.<br /><br />Ex: `-TextDiffParams @("/e", "/s", "/u", "/wl", "/wr", "/dl", "Current Result", "/dr", "Certified Result", "{CurrentResult}", "{CertifiedResult}"`) |
| -TestName | Optional. If present, is included in the `Name` property of the return object.<br /><br />Ex: `-TestName "1000 Load BPS Security"` |

**Returns**

An object with the following properties:

* Name &ndash; Contains the value passed in the `-TestName` argument
* Status &ndash; `PASSED` or `FAILED`
* Time &ndash; The execution time of the Markit EDM Component being tested
* Reason &ndash; if Status is `FAILED`, Reason will contain the diff results showing where the test result file is different from the certified file.

[Back to Top](#welcome-to-deltatest)

# Scripts

The deltaTest repository contains a number of scripts that provide utility functions or leverage the module in useful ways.

[Back to Top](#welcome-to-deltatest)

## cert.ps1

This script powers the +CERTIFY shortcut in the main directory of the repository. When a user drops a file onto this shortcut, the *cert.ps1* creates a copy of the file in the same location, with ".certified" inserted at the end of the file name and before the extension.

For example, *Result.txt* would generate *Result.certified.txt*.

[Back to Top](#welcome-to-deltatest)

## GenerateTestData.ps1

This script generates a CSV of test data based on a database table schema, with an interactive user experience. The script leverages cmdlets *Read-UserEntry* and *Export-CsvTestData*.

[Back to Top](#welcome-to-deltatest)

## runall.ps1

This script powers the +RUNALL shortcut in the main directory of the repository. When a user drops a directory onto this shortcut, all .PS1 scripts inside the directory are executed with recursion.

[Back to Top](#welcome-to-deltatest)

# Database Objects

The DB directory contains a number of database objects intended to assist in the extraction of test results.

[Back to Top](#welcome-to-deltatest)

## dbo.tvf_Core_Rows

This table-valued function generates a sequence of integers as a one-column rowset.

**Parameters**

| Parameter | Data Type | Description |
|--|:--:|:--|
| @n | int | Number of rows to generate. |

[Back to Top](#welcome-to-deltatest)

## dbo.tvf_Core_Split_Delimiter

This table-valued function splits a delimited string into a rowset.

**Parameters**

| Parameter | Data Type | Description |
|--|:--:|:--|
| @String | nvarchar(max) | Delimited string. |
| @Delimiter| nvarchar(255) | String delimiter. Multiple-character delimiters are allowed. |

[Back to Top](#welcome-to-deltatest)

## dbo.usp_Core_DumpData

This stored procedure dynamically selects data from a table or a view. It is the primary method of extracting test result data from the database. Omitted parameters will acquire their default values.

**Parameters**

| Parameter | Data Type | Default Value | Description |
|--|:--:|:--|:--|
| @TableSchema| nvarchar(128) | 'dbo' | Optional. Schema of object to be queried. |
| @TableName| nvarchar(128) | | Required. Name of object to be queried. Can be either a table or a view. |
| @ColumnAction| char(1), 'I' or 'E' | 'E' | Optional. Specifies whether columns matching the patterns expressed in @ColumnList should be [I]ncluded or [E]xcluded. |
| @ColumnList | nvarchar(max) | '%RunId,CADIS\\\_SYSTEM\\\_%' | Optional. Comma-delimited list of LIKE-syntax patterns that specify columns to be included or excluded form the query. Escape special characters with a '\\'. |
| @Where| nvarchar(max) | NULL | Optional. Logical expression that will be applied to the query in a WHERE clause. |
| @OrderBy| nvarchar(max) | NULL | Optional. Column list that will be applied to the query in an ORDER BY clause. |

[Back to Top](#welcome-to-deltatest)
