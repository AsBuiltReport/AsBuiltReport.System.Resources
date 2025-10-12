# culture = 'ja-JP'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel が {1} に設定されました。
    Collecting  = システム日付情報を収集しています。
    ParagraphDetail = 以下のセクションでは、システム日付について詳しく説明します。
    ParagraphSummary = 以下の表は、システム日付をまとめたものです。
    Heading = 日付

    Date = 日付
    Hour = 時刻
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel が {1} に設定されました。
    Collecting  = システムプロセス情報を収集しています。
    ParagraphDetail = 以下のセクションでは、システムプロセスについて詳しく説明します。
    ParagraphSummary = 以下の表は、上位10のシステムプロセスをまとめたものです。より詳細な情報については、レポート構成ファイルで InfoLevel.ProcessInfo の値を 2 に設定してください。CPU使用率順に並べ替え。
    Heading = プロセス

    Name = 名前
    Id = ID
    CPU = CPU (%)
    Memory = メモリ (MB)
    Company = 会社
    Product = 製品
    Unknown = 不明
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel が {1} に設定されました。
    Collecting  = システムタイムゾーン情報を収集しています。
    ParagraphDetail = 以下のセクションでは、システムタイムゾーンについて詳しく説明します。
    ParagraphSummary = 以下の表は、システムタイムゾーンをまとめたものです。
    Heading = タイムゾーン

    TimeZone = タイムゾーン
    Id = ID
    DisplayName = 表示名
    CurrentTime = 現在時刻
    BaseUTCOffset = 基本UTCオフセット
    SupportsDaylightSavingTime = 夏時間に対応
    Yes = はい
    No = いいえ
    Unknown = 不明
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel が {1} に設定されました。
    Collecting = システム稼働時間情報を収集しています。
    ParagraphDetail = 以下のセクションでは、システム稼働時間について詳しく説明します。
    ParagraphSummary = 以下の表は、システム稼働時間をまとめたものです。
    Heading = 稼働時間

    Uptime = 稼働時間
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel が {1} に設定されました。
    Collecting = システム PowerShell Host 情報を収集しています。
    ParagraphDetail = 以下のセクションでは、システム PowerShell Host について詳しく説明します。
    ParagraphSummary = 以下の表は、システム PowerShell Host をまとめたものです。
    Heading = PowerShell Host

    Name = 名前
    Version = バージョン
    CurrentCulture = 現在のカルチャ
    CurrentUICulture = 現在のUIカルチャ
    DebuggerEnabled = デバッガーが有効
    Yes = はい
    No = いいえ
    Unknown = 不明
'@
}
