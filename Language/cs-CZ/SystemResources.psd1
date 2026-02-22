# culture = 'cs-CZ'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel nastaven na {1}.
    Collecting  = Shromažďování informací o systémovém datu.
    ParagraphDetail = Následující části podrobně popisují systémové datum.
    ParagraphSummary = Následující tabulka shrnuje systémové datum.
    Heading = Datum

    Date = Datum
    Hour = Hodina
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel nastaven na {1}.
    Collecting  = Shromažďování informací o systémových procesech.
    ParagraphDetail = Následující části podrobně popisují systémové procesy.
    ParagraphSummary = Následující tabulka shrnuje top 5 systémových procesů. Pro podrobnější informace nastavte hodnotu InfoLevel.ProcessInfo na 2 v konfiguračním souboru sestavy. Seřazeno podle využití CPU.
    Heading = Procesy

    Name = Název
    Id = Id
    CPU = CPU (%)
    Memory = Paměť (MB)
    Company = Společnost
    Product = Produkt
    Unknown = Neznámý
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel nastaven na {1}.
    Collecting  = Shromažďování informací o systémovém časovém pásmu.
    ParagraphDetail = Následující části podrobně popisují systémové časové pásmo.
    ParagraphSummary = Následující tabulka shrnuje systémové časové pásmo.
    Heading = Časové pásmo

    TimeZone = Časové pásmo
    Id = Id
    DisplayName = Zobrazovaný název
    CurrentTime = Aktuální čas
    BaseUTCOffset = Základní UTC offset
    SupportsDaylightSavingTime = Podpora letního času
    Yes = Ano
    No = Ne
    Unknown = Neznámý
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel nastaven na {1}.
    Collecting = Shromažďování informací o době provozu systému.
    ParagraphDetail = Následující části podrobně popisují dobu provozu systému.
    ParagraphSummary = Následující tabulka shrnuje dobu provozu systému.
    Heading = Doba provozu

    Uptime = Doba provozu
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel nastaven na {1}.
    Collecting = Shromažďování informací o hostiteli PowerShell systému.
    ParagraphDetail = Následující části podrobně popisují hostitele PowerShell systému.
    ParagraphSummary = Následující tabulka shrnuje hostitele PowerShell systému.
    Heading = Hostitel PowerShell

    Name = Název
    Version = Verze
    CurrentCulture = Aktuální kultura
    CurrentUICulture = Aktuální kultura UI
    DebuggerEnabled = Debugger povolen
    Yes = Ano
    No = Ne
    Unknown = Neznámý
'@
}
