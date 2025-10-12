# culture = 'zh-Hans'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel 设置为 {1}。
    Collecting  = 正在收集系统日期信息。
    ParagraphDetail = 以下各节详细说明系统日期。
    ParagraphSummary = 下表总结了系统日期。
    Heading = 日期

    Date = 日期
    Hour = 小时
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel 设置为 {1}。
    Collecting  = 正在收集系统进程信息。
    ParagraphDetail = 以下各节详细说明系统进程。
    ParagraphSummary = 下表总结了前 10 个系统进程。如需更详细的信息，请在报告配置文件中将 InfoLevel.ProcessInfo 值设置为 2。按 CPU 使用率排序。
    Heading = 进程

    Name = 名称
    Id = Id
    CPU = CPU (%)
    Memory = 内存 (MB)
    Company = 公司
    Product = 产品
    Unknown = 未知
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 设置为 {1}。
    Collecting  = 正在收集系统时区信息。
    ParagraphDetail = 以下各节详细说明系统时区。
    ParagraphSummary = 下表总结了系统时区。
    Heading = 时区

    TimeZone = 时区
    Id = Id
    DisplayName = 显示名称
    CurrentTime = 当前时间
    BaseUTCOffset = 基准 UTC 偏移
    SupportsDaylightSavingTime = 支持夏令时
    Yes = 是
    No = 否
    Unknown = 未知
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 设置为 {1}。
    Collecting = 正在收集系统正常运行时间信息。
    ParagraphDetail = 以下各节详细说明系统正常运行时间。
    ParagraphSummary = 下表总结了系统正常运行时间。
    Heading = 正常运行时间

    Uptime = 正常运行时间
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 设置为 {1}。
    Collecting = 正在收集系统 PowerShell 主机信息。
    ParagraphDetail = 以下各节详细说明系统 PowerShell 主机。
    ParagraphSummary = 下表总结了系统 PowerShell 主机。
    Heading = PowerShell 主机

    Name = 名称
    Version = 版本
    CurrentCulture = 当前区域性
    CurrentUICulture = 当前 UI 区域性
    DebuggerEnabled = 调试器已启用
    Yes = 是
    No = 否
    Unknown = 未知
'@
}
