# culture = 'da-DK'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel indstillet til {1}.
    Collecting  = Indsamler systembeskrivelser for dato.
    ParagraphDetail = Følgende afsnit beskriver systemdatoen.
    ParagraphSummary = Følgende tabel opsummerer systemdatoen.
    Heading = Dato

    Date = Dato
    Hour = Time
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel indstillet til {1}.
    Collecting  = Indsamler information om systemprocesser.
    ParagraphDetail = Følgende afsnit beskriver systemprocesserne.
    ParagraphSummary = Følgende tabel opsummerer de top 10 systemprocesser. For mere detaljeret information skal du indstille InfoLevel.ProcessInfo værdien til 2 i din rapportkonfigurationsfil. Sorteret efter CPU-brug.
    Heading = Processer

    Name = Navn
    Id = Id
    CPU = CPU (%)
    Memory = Hukommelse (MB)
    Company = Virksomhed
    Product = Produkt
    Unknown = Ukendt
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel indstillet til {1}.
    Collecting  = Indsamler information om systemets tidszone.
    ParagraphDetail = Følgende afsnit beskriver systemets tidszone.
    ParagraphSummary = Følgende tabel opsummerer systemets tidszone.
    Heading = Tidszone

    TimeZone = Tidszone
    Id = Id
    DisplayName = Visningsnavn
    CurrentTime = Aktuel tid
    BaseUTCOffset = Basis UTC-forskydning
    SupportsDaylightSavingTime = Understøtter sommertid
    Yes = Ja
    No = Nej
    Unknown = Ukendt
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel indstillet til {1}.
    Collecting = Indsamler information om systemets oppetid.
    ParagraphDetail = Følgende afsnit beskriver systemets oppetid.
    ParagraphSummary = Følgende tabel opsummerer systemets oppetid.
    Heading = Oppetid

    Uptime = Oppetid
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel indstillet til {1}.
    Collecting = Indsamler information om systemets PowerShell Host.
    ParagraphDetail = Følgende afsnit beskriver systemets PowerShell Host.
    ParagraphSummary = Følgende tabel opsummerer systemets PowerShell Host.
    Heading = PowerShell Host

    Name = Navn
    Version = Version
    CurrentCulture = Aktuel kultur
    CurrentUICulture = Aktuel UI-kultur
    DebuggerEnabled = Debugger aktiveret
    Yes = Ja
    No = Nej
    Unknown = Ukendt
'@
}
