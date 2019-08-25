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

# Links

[Current Release](https://github.com/enterprise-data-foundation/delta-test/tree/v2.0.0)

[Official Website](https://enterprise-data.org)

[deltaTest in a Nutshell](https://enterprise-data.org/2019/01/12/delta-test-in-a-nutshell/)

[Getting Started](https://enterprise-data.org/docs/delta-test-cmdlets-getting-started/)

[Full documentation](<https://enterprise-data.org/docs/>)
