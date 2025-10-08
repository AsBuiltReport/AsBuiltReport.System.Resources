# culture = 'en-US'
@{

    InvokeAsBuiltReportSystemResources = ConvertFrom-StringData @'
    Message1 = - Please refer to the AsBuiltReport.System.Resources github website for more detailed information about this project.
    Message2 = - Do not forget to update your report configuration file after each new version release: https://www.asbuiltreport.com/user-guide/new-asbuiltreportconfig/
    Message3 = - Documentation: https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    Message4 = - Issues or bug reporting: https://github.com/AsBuiltReport/AsBuiltReport.System.Resources/issues
    Message5 = - This project is community maintained and has no sponsorship from Microsoft/*Linux/MacOS, its employees or any of its affiliates.


    ModuleStatus = - The module {0} {1} is currently installed.
    ModuleAvailable = - The module {0} {1} is available.
    ModuleUpdateCmd = - Run 'Update-Module -Name {0} -Force' to install the latest version.

'@
    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel set at {1}.
    Collecting  = Collecting System Date information.
    ParagraphDetail = The following sections detail the system date.
    ParagraphSummary = The following table summarises the system date.
    Heading = Date

    Date = Date
    Hour = Hour
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel set at {1}.
    Collecting  = Collecting System Process information.
    ParagraphDetail = The following sections detail the system process.
    ParagraphSummary = The following table summarises the top 10 system process. For more detailed information, please set the InfoLevel.ProcessInfo value to 2 in your report configuration file. Sorted by CPU usage.
    Heading = Process

    Name = Name
    Id = Id
    CPU = CPU (%)
    Memory = Memory (MB)
    Company = Company
    Product = Product
    Unknown = Unknown
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel set at {1}.
    Collecting  = Collecting System TimeZone information.
    ParagraphDetail = The following sections detail the system TimeZone.
    ParagraphSummary = The following table summarises the system TimeZone.
    Heading = TimeZone

    TimeZone = TimeZone
    Id = Id
    DisplayName = DisplayName
    CurrentTime = Current Time
    BaseUTCOffset = Base UTC Offset
    SupportsDaylightSavingTime = Supports Daylight Saving Time
    Yes = Yes
    No = No
    Unknown = Unknown
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel set at {1}.
    Collecting = Collecting System Uptime information.
    ParagraphDetail = The following sections detail the system Uptime.
    ParagraphSummary = The following table summarises the system Uptime.
    Heading = Uptime

    Uptime = Uptime
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel set at {1}.
    Collecting = Collecting System PowerShell Host information.
    ParagraphDetail = The following sections detail the system PowerShell Host.
    ParagraphSummary = The following table summarises the system PowerShell Host.
    Heading = PowerShell Host

    Name = Name
    Version = Version
    CurrentCulture = Current Culture
    CurrentUICulture = Current UI Culture
    DebuggerEnabled = Debugger Enabled
    Yes = Yes
    No = No
    Unknown = Unknown
'@
}