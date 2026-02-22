# culture = 'nl-NL'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ingesteld op {1}.
    Collecting  = Verzamelen van systeemdatuminformatie.
    ParagraphDetail = De volgende secties beschrijven de systeemdatum.
    ParagraphSummary = De volgende tabel geeft een overzicht van de systeemdatum.
    Heading = Datum

    Date = Datum
    Hour = Uur
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ingesteld op {1}.
    Collecting  = Verzamelen van systeemprocesinformatie.
    ParagraphDetail = De volgende secties beschrijven de systeemprocessen.
    ParagraphSummary = De volgende tabel geeft een overzicht van de top 5 systeemprocessen. Voor meer gedetailleerde informatie stelt u de waarde InfoLevel.ProcessInfo in op 2 in uw rapportconfiguratiebestand. Gesorteerd op CPU-gebruik.
    Heading = Processen

    Name = Naam
    Id = Id
    CPU = CPU (%)
    Memory = Geheugen (MB)
    Company = Bedrijf
    Product = Product
    Unknown = Onbekend

    Generating = Genereren van procesdiagram.
    Label = Proceshiërarchie
    MainDiagramLabel = Proceshiërarchiediagram
    Unable = Kan het proceshiërarchiediagram niet genereren.
    MEMUsage = Geheugen gebruik
    CPUUsage = CPU gebruik
    Processes = Processen
    MEMUsageChart = Geheugen gebruik - Diagram
    CPUUsageChart = CPU gebruik - Diagram
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ingesteld op {1}.
    Collecting  = Verzamelen van systeemtijdzone-informatie.
    ParagraphDetail = De volgende secties beschrijven de systeemtijdzone.
    ParagraphSummary = De volgende tabel geeft een overzicht van de systeemtijdzone.
    Heading = Tijdzone

    TimeZone = Tijdzone
    Id = Id
    DisplayName = Weergavenaam
    CurrentTime = Huidige tijd
    BaseUTCOffset = Basis UTC-verschuiving
    SupportsDaylightSavingTime = Ondersteunt zomertijd
    Yes = Ja
    No = Nee
    Unknown = Onbekend
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ingesteld op {1}.
    Collecting = Verzamelen van systeembedrijfstijdinformatie.
    ParagraphDetail = De volgende secties beschrijven de systeembedrijfstijd.
    ParagraphSummary = De volgende tabel geeft een overzicht van de systeembedrijfstijd.
    Heading = Bedrijfstijd

    Uptime = Bedrijfstijd
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ingesteld op {1}.
    Collecting = Verzamelen van systeem PowerShell Host-informatie.
    ParagraphDetail = De volgende secties beschrijven de systeem PowerShell Host.
    ParagraphSummary = De volgende tabel geeft een overzicht van de systeem PowerShell Host.
    Heading = PowerShell Host

    Name = Naam
    Version = Versie
    CurrentCulture = Huidige cultuur
    CurrentUICulture = Huidige UI-cultuur
    DebuggerEnabled = Debugger ingeschakeld
    Yes = Ja
    No = Nee
    Unknown = Onbekend
'@
}
