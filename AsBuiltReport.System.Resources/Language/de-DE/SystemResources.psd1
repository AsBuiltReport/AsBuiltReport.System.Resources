# culture = 'de-DE'
@{
    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel auf {1} gesetzt.
    Collecting  = Sammeln von Systemdatumsinformationen.
    ParagraphDetail = Die folgenden Abschnitte beschreiben das Systemdatum.
    ParagraphSummary = Die folgende Tabelle fasst das Systemdatum zusammen.
    Heading = Datum

    Date = Datum
    Hour = Stunde
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel auf {1} gesetzt.
    Collecting  = Sammeln von Systemprozessinformationen.
    ParagraphDetail = Die folgenden Abschnitte beschreiben die Systemprozesse.
    ParagraphSummary = Die folgende Tabelle fasst die Top 5 Systemprozesse zusammen. Für detailliertere Informationen setzen Sie bitte den Wert InfoLevel.ProcessInfo in Ihrer Berichtskonfigurationsdatei auf 2. Sortiert nach CPU-Auslastung.
    Heading = Prozesse

    Name = Name
    Id = Id
    CPU = CPU (%)
    Memory = Speicher (MB)
    Company = Unternehmen
    Product = Produkt
    Unknown = Unbekannt

    Generating = Generieren des Prozessdiagramms.
    Label = Prozesshierarchie
    MainDiagramLabel = Prozesshierarchiediagramm
    Unable = Unfähig, das Prozesshierarchiediagramm zu generieren.
    MEMUsage = Speichernutzung
    CPUUsage = CPU-Auslastung
    Processes = Prozesse
    MEMUsageChart = Speichernutzung - Diagramm
    CPUUsageChart = CPU-Auslastung - Diagramm
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel auf {1} gesetzt.
    Collecting  = Sammeln von Systemzeitzoneninformationen.
    ParagraphDetail = Die folgenden Abschnitte beschreiben die Systemzeitzone.
    ParagraphSummary = Die folgende Tabelle fasst die Systemzeitzone zusammen.
    Heading = Zeitzone

    TimeZone = Zeitzone
    Id = Id
    DisplayName = Anzeigename
    CurrentTime = Aktuelle Zeit
    BaseUTCOffset = Basis UTC-Verschiebung
    SupportsDaylightSavingTime = Unterstützt Sommerzeit
    Yes = Ja
    No = Nein
    Unknown = Unbekannt
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel auf {1} gesetzt.
    Collecting = Sammeln von Systembetriebszeitinformationen.
    ParagraphDetail = Die folgenden Abschnitte beschreiben die Systembetriebszeit.
    ParagraphSummary = Die folgende Tabelle fasst die Systembetriebszeit zusammen.
    Heading = Betriebszeit

    Uptime = Betriebszeit
    HealthCheck = Health Check
    CorrectiveActions = Corrective Actions:
    Downtime = System Uptime is below 24 hours. Review the system logs to identify any events that may have caused the unexpected downtime.
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel auf {1} gesetzt.
    Collecting = Sammeln von System PowerShell Host-Informationen.
    ParagraphDetail = Die folgenden Abschnitte beschreiben den System PowerShell Host.
    ParagraphSummary = Die folgende Tabelle fasst den System PowerShell Host zusammen.
    Heading = PowerShell Host

    Name = Name
    Version = Version
    CurrentCulture = Aktuelle Kultur
    CurrentUICulture = Aktuelle UI-Kultur
    DebuggerEnabled = Debugger aktiviert
    Yes = Ja
    No = Nein
    Unknown = Unbekannt
'@
}
