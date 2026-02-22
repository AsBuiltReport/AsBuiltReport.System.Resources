# culture = 'nb-NO'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel satt til {1}.
    Collecting  = Samler informasjon om systemdato.
    ParagraphDetail = Følgende avsnitt beskriver systemdatoen.
    ParagraphSummary = Følgende tabell oppsummerer systemdatoen.
    Heading = Dato

    Date = Dato
    Hour = Time
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel satt til {1}.
    Collecting  = Samler informasjon om systemprosesser.
    ParagraphDetail = Følgende avsnitt beskriver systemprosessene.
    ParagraphSummary = Følgende tabell oppsummerer de 5 viktigste systemprosessene. For mer detaljert informasjon, sett InfoLevel.ProcessInfo-verdien til 2 i rapportkonfigurasjonsfilen din. Sortert etter CPU-bruk.
    Heading = Prosesser

    Name = Navn
    Id = Id
    CPU = CPU (%)
    Memory = Minne (MB)
    Company = Selskap
    Product = Produkt
    Unknown = Ukjent
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel satt til {1}.
    Collecting  = Samler informasjon om systemets tidssone.
    ParagraphDetail = Følgende avsnitt beskriver systemets tidssone.
    ParagraphSummary = Følgende tabell oppsummerer systemets tidssone.
    Heading = Tidssone

    TimeZone = Tidssone
    Id = Id
    DisplayName = Visningsnavn
    CurrentTime = Nåværende tid
    BaseUTCOffset = Basis UTC-forskyvning
    SupportsDaylightSavingTime = Støtter sommertid
    Yes = Ja
    No = Nei
    Unknown = Ukjent
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel satt til {1}.
    Collecting = Samler informasjon om systemets oppetid.
    ParagraphDetail = Følgende avsnitt beskriver systemets oppetid.
    ParagraphSummary = Følgende tabell oppsummerer systemets oppetid.
    Heading = Oppetid

    Uptime = Oppetid
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel satt til {1}.
    Collecting = Samler informasjon om systemets PowerShell Host.
    ParagraphDetail = Følgende avsnitt beskriver systemets PowerShell Host.
    ParagraphSummary = Følgende tabell oppsummerer systemets PowerShell Host.
    Heading = PowerShell Host

    Name = Navn
    Version = Versjon
    CurrentCulture = Gjeldende kultur
    CurrentUICulture = Gjeldende UI-kultur
    DebuggerEnabled = Feilsøker aktivert
    Yes = Ja
    No = Nei
    Unknown = Ukjent
'@
}
