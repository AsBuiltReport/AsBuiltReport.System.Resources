# culture = 'pl-PL'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ustawiony na {1}.
    Collecting  = Zbieranie informacji o dacie systemowej.
    ParagraphDetail = Poniższe sekcje szczegółowo opisują datę systemową.
    ParagraphSummary = Poniższa tabela podsumowuje datę systemową.
    Heading = Data

    Date = Data
    Hour = Godzina
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ustawiony na {1}.
    Collecting  = Zbieranie informacji o procesach systemowych.
    ParagraphDetail = Poniższe sekcje szczegółowo opisują procesy systemowe.
    ParagraphSummary = Poniższa tabela podsumowuje 5 najważniejszych procesów systemowych. Aby uzyskać bardziej szczegółowe informacje, ustaw wartość InfoLevel.ProcessInfo na 2 w pliku konfiguracji raportu. Posortowane według użycia CPU.
    Heading = Procesy

    Name = Nazwa
    Id = Id
    CPU = CPU (%)
    Memory = Pamięć (MB)
    Company = Firma
    Product = Produkt
    Unknown = Nieznany
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ustawiony na {1}.
    Collecting  = Zbieranie informacji o strefie czasowej systemu.
    ParagraphDetail = Poniższe sekcje szczegółowo opisują strefę czasową systemu.
    ParagraphSummary = Poniższa tabela podsumowuje strefę czasową systemu.
    Heading = Strefa czasowa

    TimeZone = Strefa czasowa
    Id = Id
    DisplayName = Nazwa wyświetlana
    CurrentTime = Bieżący czas
    BaseUTCOffset = Podstawowe przesunięcie UTC
    SupportsDaylightSavingTime = Obsługuje czas letni
    Yes = Tak
    No = Nie
    Unknown = Nieznany
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ustawiony na {1}.
    Collecting = Zbieranie informacji o czasie pracy systemu.
    ParagraphDetail = Poniższe sekcje szczegółowo opisują czas pracy systemu.
    ParagraphSummary = Poniższa tabela podsumowuje czas pracy systemu.
    Heading = Czas pracy

    Uptime = Czas pracy
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ustawiony na {1}.
    Collecting = Zbieranie informacji o hoście PowerShell systemu.
    ParagraphDetail = Poniższe sekcje szczegółowo opisują hosta PowerShell systemu.
    ParagraphSummary = Poniższa tabela podsumowuje hosta PowerShell systemu.
    Heading = Host PowerShell

    Name = Nazwa
    Version = Wersja
    CurrentCulture = Bieżąca kultura
    CurrentUICulture = Bieżąca kultura UI
    DebuggerEnabled = Debuger włączony
    Yes = Tak
    No = Nie
    Unknown = Nieznany
'@
}
