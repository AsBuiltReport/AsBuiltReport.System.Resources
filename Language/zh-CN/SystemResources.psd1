# culture = 'zh-CN'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel 设置为 {1}。
    Collecting  = 正在收集系统日期信息。
    ParagraphDetail = 以下各节详细说明了系统日期。
    ParagraphSummary = 下表汇总了系统日期。
    Heading = 日期

    Date = 日期
    Hour = 小时
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel 设置为 {1}。
    Collecting  = 正在收集系统进程信息。
    ParagraphDetail = 以下各节详细说明了系统进程。
    ParagraphSummary = 下表汇总了前10个系统进程。有关更详细的信息,请在报告配置文件中将 InfoLevel.ProcessInfo 值设置为 2。按 CPU 使用率排序。
    Heading = 进程

    Name = 名称
    Id = ID
    CPU = CPU (%)
    Memory = 内存 (MB)
    Company = 公司
    Product = 产品
    Unknown = 未知

    Generating = 正在生成进程图。
    Label = 进程层次结构
    MainDiagramLabel = 进程层次结构图
    Unable = 无法生成进程层次结构图。
    MEMUsage = 内存使用情况
    CPUUsage = CPU 使用情况
    Processes = 进程
    MEMUsageChart = 内存使用情况 - 图表
    CPUUsageChart = CPU 使用情况 - 图表
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 设置为 {1}。
    Collecting  = 正在收集系统时区信息。
    ParagraphDetail = 以下各节详细说明了系统时区。
    ParagraphSummary = 下表汇总了系统时区。
    Heading = 时区

    TimeZone = 时区
    Id = ID
    DisplayName = 显示名称
    CurrentTime = 当前时间
    BaseUTCOffset = 基准UTC偏移量
    SupportsDaylightSavingTime = 支持夏令时
    Yes = 是
    No = 否
    Unknown = 未知
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 设置为 {1}。
    Collecting = 正在收集系统运行时间信息。
    ParagraphDetail = 以下各节详细说明了系统运行时间。
    ParagraphSummary = 下表汇总了系统运行时间。
    Heading = 运行时间

    Uptime = 运行时间
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 设置为 {1}。
    Collecting = 正在收集系统 PowerShell Host 信息。
    ParagraphDetail = 以下各节详细说明了系统 PowerShell Host。
    ParagraphSummary = 下表汇总了系统 PowerShell Host。
    Heading = PowerShell Host

    Name = 名称
    Version = 版本
    CurrentCulture = 当前区域性
    CurrentUICulture = 当前UI区域性
    DebuggerEnabled = 已启用调试器
    Yes = 是
    No = 否
    Unknown = 未知
'@
}
