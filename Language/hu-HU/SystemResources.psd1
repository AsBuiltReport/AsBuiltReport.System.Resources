# culture = 'hu-HU'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel beállítva: {1}.
    Collecting  = Rendszer dátum információk gyűjtése.
    ParagraphDetail = Az alábbi szakaszok részletezik a rendszer dátumát.
    ParagraphSummary = Az alábbi táblázat összefoglalja a rendszer dátumát.
    Heading = Dátum

    Date = Dátum
    Hour = Óra
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel beállítva: {1}.
    Collecting  = Rendszer folyamat információk gyűjtése.
    ParagraphDetail = Az alábbi szakaszok részletezik a rendszer folyamatokat.
    ParagraphSummary = Az alábbi táblázat összefoglalja a top 5 rendszer folyamatot. Részletesebb információkért állítsa az InfoLevel.ProcessInfo értéket 2-re a jelentés konfigurációs fájlban. CPU használat szerint rendezve.
    Heading = Folyamatok

    Name = Név
    Id = Azonosító
    CPU = CPU (%)
    Memory = Memória (MB)
    Company = Cég
    Product = Termék
    Unknown = Ismeretlen
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel beállítva: {1}.
    Collecting  = Rendszer időzóna információk gyűjtése.
    ParagraphDetail = Az alábbi szakaszok részletezik a rendszer időzónáját.
    ParagraphSummary = Az alábbi táblázat összefoglalja a rendszer időzónáját.
    Heading = Időzóna

    TimeZone = Időzóna
    Id = Azonosító
    DisplayName = Megjelenítési név
    CurrentTime = Jelenlegi idő
    BaseUTCOffset = Alap UTC eltolás
    SupportsDaylightSavingTime = Támogatja a nyári időszámítást
    Yes = Igen
    No = Nem
    Unknown = Ismeretlen
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel beállítva: {1}.
    Collecting = Rendszer üzemidő információk gyűjtése.
    ParagraphDetail = Az alábbi szakaszok részletezik a rendszer üzemidejét.
    ParagraphSummary = Az alábbi táblázat összefoglalja a rendszer üzemidejét.
    Heading = Üzemidő

    Uptime = Üzemidő
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel beállítva: {1}.
    Collecting = Rendszer PowerShell Host információk gyűjtése.
    ParagraphDetail = Az alábbi szakaszok részletezik a rendszer PowerShell Host-ját.
    ParagraphSummary = Az alábbi táblázat összefoglalja a rendszer PowerShell Host-ját.
    Heading = PowerShell Host

    Name = Név
    Version = Verzió
    CurrentCulture = Jelenlegi kultúra
    CurrentUICulture = Jelenlegi UI kultúra
    DebuggerEnabled = Hibakereső engedélyezve
    Yes = Igen
    No = Nem
    Unknown = Ismeretlen
'@
}
