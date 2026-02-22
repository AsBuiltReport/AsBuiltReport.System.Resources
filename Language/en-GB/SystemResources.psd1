# culture = 'en-GB'
@{

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
    ParagraphSummary = The following table summarises the top 5 system process. For more detailed information, please set the InfoLevel.ProcessInfo value to 2 in your report configuration file. Sorted by CPU usage.
    Heading = Process

    Name = Name
    Id = Id
    CPU = CPU (%)
    Memory = Memory (MB)
    Company = Company
    Product = Product
    Unknown = Unknown

    Generating = Generating Process Diagram.
    Label = Process Hierarchy
    MainDiagramLabel = Process Hierarchy Diagram
    Unable = Unable to generate the Process Hierarchy Diagram.
    MEMUsage = Memory Usage 
    CPUUsage = CPU Usage
    Processes = Processes
    MEMUsageChart = Memory Usage - Chart
    CPUUsageChart = CPU Usage - Chart
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
