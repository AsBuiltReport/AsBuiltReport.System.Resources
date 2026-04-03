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

    Generating = Generazione del diagramma dei processi.
    Label = Gerarchia dei processi
    MainDiagramLabel = Diagramma della gerarchia dei processi
    Unable = Impossibile generare il diagramma della gerarchia dei processi.
    MEMUsage = Uso di Memoria
    CPUUsage = Uso di CPU
    Processes = Processi
    MEMUsageChart = Uso di Memoria - Grafico
    CPUUsageChart = Uso di CPU - Grafico
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
    HealthCheck = Health Check
    CorrectiveActions = Corrective Actions:
    Downtime = System Uptime is below 24 hours. Review the system logs to identify any events that may have caused the unexpected downtime.
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
