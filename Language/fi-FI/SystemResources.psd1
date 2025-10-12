# culture = 'fi-FI'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel asetettu arvoon {1}.
    Collecting  = Kerätään järjestelmän päivämäärätietoja.
    ParagraphDetail = Seuraavissa osioissa kuvataan järjestelmän päivämäärä.
    ParagraphSummary = Seuraava taulukko tiivistää järjestelmän päivämäärän.
    Heading = Päivämäärä

    Date = Päivämäärä
    Hour = Tunti
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel asetettu arvoon {1}.
    Collecting  = Kerätään järjestelmän prosessitietoja.
    ParagraphDetail = Seuraavissa osioissa kuvataan järjestelmän prosessit.
    ParagraphSummary = Seuraava taulukko tiivistää 10 tärkeintä järjestelmäprosessia. Tarkempia tietoja varten aseta InfoLevel.ProcessInfo-arvo arvoksi 2 raportin asetustiedostossa. Lajiteltu CPU-käytön mukaan.
    Heading = Prosessit

    Name = Nimi
    Id = Id
    CPU = CPU (%)
    Memory = Muisti (MB)
    Company = Yritys
    Product = Tuote
    Unknown = Tuntematon
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel asetettu arvoon {1}.
    Collecting  = Kerätään järjestelmän aikavyöhyketietoja.
    ParagraphDetail = Seuraavissa osioissa kuvataan järjestelmän aikavyöhyke.
    ParagraphSummary = Seuraava taulukko tiivistää järjestelmän aikavyöhykkeen.
    Heading = Aikavyöhyke

    TimeZone = Aikavyöhyke
    Id = Id
    DisplayName = Näyttönimi
    CurrentTime = Nykyinen aika
    BaseUTCOffset = Perus UTC-siirtymä
    SupportsDaylightSavingTime = Tukee kesäaikaa
    Yes = Kyllä
    No = Ei
    Unknown = Tuntematon
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel asetettu arvoon {1}.
    Collecting = Kerätään järjestelmän käyttöaikatietoja.
    ParagraphDetail = Seuraavissa osioissa kuvataan järjestelmän käyttöaika.
    ParagraphSummary = Seuraava taulukko tiivistää järjestelmän käyttöajan.
    Heading = Käyttöaika

    Uptime = Käyttöaika
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel asetettu arvoon {1}.
    Collecting = Kerätään järjestelmän PowerShell Host -tietoja.
    ParagraphDetail = Seuraavissa osioissa kuvataan järjestelmän PowerShell Host.
    ParagraphSummary = Seuraava taulukko tiivistää järjestelmän PowerShell Host -tiedot.
    Heading = PowerShell Host

    Name = Nimi
    Version = Versio
    CurrentCulture = Nykyinen kulttuuri
    CurrentUICulture = Nykyinen UI-kulttuuri
    DebuggerEnabled = Virheenkorjaus käytössä
    Yes = Kyllä
    No = Ei
    Unknown = Tuntematon
'@
}
