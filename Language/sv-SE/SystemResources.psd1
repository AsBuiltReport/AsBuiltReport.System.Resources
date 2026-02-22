# culture = 'sv-SE'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel inställd på {1}.
    Collecting  = Samlar information om systemdatum.
    ParagraphDetail = Följande avsnitt beskriver systemdatumet.
    ParagraphSummary = Följande tabell sammanfattar systemdatumet.
    Heading = Datum

    Date = Datum
    Hour = Timme
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel inställd på {1}.
    Collecting  = Samlar information om systemprocesser.
    ParagraphDetail = Följande avsnitt beskriver systemprocesserna.
    ParagraphSummary = Följande tabell sammanfattar de 5 viktigaste systemprocesserna. För mer detaljerad information, ställ in värdet InfoLevel.ProcessInfo till 2 i din rapportkonfigurationsfil. Sorterad efter CPU-användning.
    Heading = Processer

    Name = Namn
    Id = Id
    CPU = CPU (%)
    Memory = Minne (MB)
    Company = Företag
    Product = Produkt
    Unknown = Okänd

    Generating = Genererar processdiagram.
    Label = Processhierarki
    MainDiagramLabel = Processhierarkidiagram
    Unable = Kan inte generera processhierarkidiagrammet.
    MEMUsage = Användning av minne
    CPUUsage = Användning av CPU
    Processes = Processer
    MEMUsageChart = Användning av minne - Diagram
    CPUUsageChart = Användning av CPU - Diagram
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel inställd på {1}.
    Collecting  = Samlar information om systemets tidszon.
    ParagraphDetail = Följande avsnitt beskriver systemets tidszon.
    ParagraphSummary = Följande tabell sammanfattar systemets tidszon.
    Heading = Tidszon

    TimeZone = Tidszon
    Id = Id
    DisplayName = Visningsnamn
    CurrentTime = Aktuell tid
    BaseUTCOffset = UTC-basförskjutning
    SupportsDaylightSavingTime = Stöder sommartid
    Yes = Ja
    No = Nej
    Unknown = Okänd
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel inställd på {1}.
    Collecting = Samlar information om systemets drifttid.
    ParagraphDetail = Följande avsnitt beskriver systemets drifttid.
    ParagraphSummary = Följande tabell sammanfattar systemets drifttid.
    Heading = Drifttid

    Uptime = Drifttid
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel inställd på {1}.
    Collecting = Samlar information om systemets PowerShell Host.
    ParagraphDetail = Följande avsnitt beskriver systemets PowerShell Host.
    ParagraphSummary = Följande tabell sammanfattar systemets PowerShell Host.
    Heading = PowerShell Host

    Name = Namn
    Version = Version
    CurrentCulture = Aktuell kultur
    CurrentUICulture = Aktuell UI-kultur
    DebuggerEnabled = Felsökare aktiverad
    Yes = Ja
    No = Nej
    Unknown = Okänd
'@
}
