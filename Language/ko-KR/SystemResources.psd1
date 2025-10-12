# culture = 'ko-KR'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel이 {1}로 설정되었습니다.
    Collecting  = 시스템 날짜 정보를 수집하고 있습니다.
    ParagraphDetail = 다음 섹션에서는 시스템 날짜에 대해 자세히 설명합니다.
    ParagraphSummary = 다음 표는 시스템 날짜를 요약한 것입니다.
    Heading = 날짜

    Date = 날짜
    Hour = 시간
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel이 {1}로 설정되었습니다.
    Collecting  = 시스템 프로세스 정보를 수집하고 있습니다.
    ParagraphDetail = 다음 섹션에서는 시스템 프로세스에 대해 자세히 설명합니다.
    ParagraphSummary = 다음 표는 상위 10개의 시스템 프로세스를 요약한 것입니다. 보다 자세한 정보를 보려면 보고서 구성 파일에서 InfoLevel.ProcessInfo 값을 2로 설정하십시오. CPU 사용량별로 정렬됨.
    Heading = 프로세스

    Name = 이름
    Id = ID
    CPU = CPU (%)
    Memory = 메모리 (MB)
    Company = 회사
    Product = 제품
    Unknown = 알 수 없음
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel이 {1}로 설정되었습니다.
    Collecting  = 시스템 표준 시간대 정보를 수집하고 있습니다.
    ParagraphDetail = 다음 섹션에서는 시스템 표준 시간대에 대해 자세히 설명합니다.
    ParagraphSummary = 다음 표는 시스템 표준 시간대를 요약한 것입니다.
    Heading = 표준 시간대

    TimeZone = 표준 시간대
    Id = ID
    DisplayName = 표시 이름
    CurrentTime = 현재 시간
    BaseUTCOffset = 기본 UTC 오프셋
    SupportsDaylightSavingTime = 일광 절약 시간 지원
    Yes = 예
    No = 아니요
    Unknown = 알 수 없음
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel이 {1}로 설정되었습니다.
    Collecting = 시스템 가동 시간 정보를 수집하고 있습니다.
    ParagraphDetail = 다음 섹션에서는 시스템 가동 시간에 대해 자세히 설명합니다.
    ParagraphSummary = 다음 표는 시스템 가동 시간을 요약한 것입니다.
    Heading = 가동 시간

    Uptime = 가동 시간
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel이 {1}로 설정되었습니다.
    Collecting = 시스템 PowerShell Host 정보를 수집하고 있습니다.
    ParagraphDetail = 다음 섹션에서는 시스템 PowerShell Host에 대해 자세히 설명합니다.
    ParagraphSummary = 다음 표는 시스템 PowerShell Host를 요약한 것입니다.
    Heading = PowerShell Host

    Name = 이름
    Version = 버전
    CurrentCulture = 현재 문화권
    CurrentUICulture = 현재 UI 문화권
    DebuggerEnabled = 디버거 활성화됨
    Yes = 예
    No = 아니요
    Unknown = 알 수 없음
'@
}
