# culture = 'it-IT'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel impostato su {1}.
    Collecting  = Raccolta informazioni sulla data di sistema.
    ParagraphDetail = Le seguenti sezioni descrivono la data di sistema.
    ParagraphSummary = La seguente tabella riassume la data di sistema.
    Heading = Data

    Date = Data
    Hour = Ora
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel impostato su {1}.
    Collecting  = Raccolta informazioni sui processi di sistema.
    ParagraphDetail = Le seguenti sezioni descrivono i processi di sistema.
    ParagraphSummary = La seguente tabella riassume i primi 5 processi di sistema. Per informazioni più dettagliate, impostare il valore InfoLevel.ProcessInfo su 2 nel file di configurazione del report. Ordinati per utilizzo CPU.
    Heading = Processi

    Name = Nome
    Id = Id
    CPU = CPU (%)
    Memory = Memoria (MB)
    Company = Azienda
    Product = Prodotto
    Unknown = Sconosciuto
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel impostato su {1}.
    Collecting  = Raccolta informazioni sul fuso orario di sistema.
    ParagraphDetail = Le seguenti sezioni descrivono il fuso orario di sistema.
    ParagraphSummary = La seguente tabella riassume il fuso orario di sistema.
    Heading = Fuso orario

    TimeZone = Fuso orario
    Id = Id
    DisplayName = Nome visualizzato
    CurrentTime = Ora corrente
    BaseUTCOffset = Offset UTC di base
    SupportsDaylightSavingTime = Supporta l'ora legale
    Yes = Sì
    No = No
    Unknown = Sconosciuto
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel impostato su {1}.
    Collecting = Raccolta informazioni sul tempo di attività del sistema.
    ParagraphDetail = Le seguenti sezioni descrivono il tempo di attività del sistema.
    ParagraphSummary = La seguente tabella riassume il tempo di attività del sistema.
    Heading = Tempo di attività

    Uptime = Tempo di attività
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel impostato su {1}.
    Collecting = Raccolta informazioni sull'host PowerShell di sistema.
    ParagraphDetail = Le seguenti sezioni descrivono l'host PowerShell di sistema.
    ParagraphSummary = La seguente tabella riassume l'host PowerShell di sistema.
    Heading = Host PowerShell

    Name = Nome
    Version = Versione
    CurrentCulture = Cultura corrente
    CurrentUICulture = Cultura UI corrente
    DebuggerEnabled = Debugger abilitato
    Yes = Sì
    No = No
    Unknown = Sconosciuto
'@
}
