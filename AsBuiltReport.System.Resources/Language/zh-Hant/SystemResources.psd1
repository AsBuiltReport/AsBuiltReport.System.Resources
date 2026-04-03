# culture = 'zh-Hant'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel 設定為 {1}。
    Collecting  = 正在收集系統日期資訊。
    ParagraphDetail = 以下各節詳細說明了系統日期。
    ParagraphSummary = 下表匯總了系統日期。
    Heading = 日期

    Date = 日期
    Hour = 小時
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel 設定為 {1}。
    Collecting  = 正在收集系統處理程序資訊。
    ParagraphDetail = 以下各節詳細說明了系統處理程序。
    ParagraphSummary = 下表匯總了前10個系統處理程序。有關更詳細的資訊,請在報告設定檔中將 InfoLevel.ProcessInfo 值設定為 2。按 CPU 使用率排序。
    Heading = 處理程序

    Name = 名稱
    Id = ID
    CPU = CPU (%)
    Memory = 記憶體 (MB)
    Company = 公司
    Product = 產品
    Unknown = 未知

    Generating = 正在生成進程圖。
    Label = 進程層次結構
    MainDiagramLabel = 進程層次結構圖
    Unable = 無法生成進程層次結構圖。
    MEMUsage = 記憶體使用情況
    CPUUsage = CPU 使用情況
    Processes = 處理程序
    MEMUsageChart = 記憶體使用情況 - 圖表
    CPUUsageChart = CPU 使用情況 - 圖表
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 設定為 {1}。
    Collecting  = 正在收集系統時區資訊。
    ParagraphDetail = 以下各節詳細說明了系統時區。
    ParagraphSummary = 下表匯總了系統時區。
    Heading = 時區

    TimeZone = 時區
    Id = ID
    DisplayName = 顯示名稱
    CurrentTime = 目前時間
    BaseUTCOffset = 基準UTC位移
    SupportsDaylightSavingTime = 支援日光節約時間
    Yes = 是
    No = 否
    Unknown = 未知
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 設定為 {1}。
    Collecting = 正在收集系統執行時間資訊。
    ParagraphDetail = 以下各節詳細說明了系統執行時間。
    ParagraphSummary = 下表匯總了系統執行時間。
    Heading = 執行時間

    Uptime = 執行時間
    HealthCheck = Health Check
    CorrectiveActions = Corrective Actions:
    Downtime = System Uptime is below 24 hours. Review the system logs to identify any events that may have caused the unexpected downtime.
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel 設定為 {1}。
    Collecting = 正在收集系統 PowerShell Host 資訊。
    ParagraphDetail = 以下各節詳細說明了系統 PowerShell Host。
    ParagraphSummary = 下表匯總了系統 PowerShell Host。
    Heading = PowerShell Host

    Name = 名稱
    Version = 版本
    CurrentCulture = 目前文化特性
    CurrentUICulture = 目前UI文化特性
    DebuggerEnabled = 已啟用偵錯工具
    Yes = 是
    No = 否
    Unknown = 未知
'@
}
