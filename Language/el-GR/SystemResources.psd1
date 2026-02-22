# culture = 'el-GR'
@{
    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ορίστηκε σε {1}.
    Collecting  = Συλλογή πληροφοριών ημερομηνίας συστήματος.
    ParagraphDetail = Οι ακόλουθες ενότητες περιγράφουν την ημερομηνία του συστήματος.
    ParagraphSummary = Ο παρακάτω πίνακας συνοψίζει την ημερομηνία του συστήματος.
    Heading = Ημερομηνία

    Date = Ημερομηνία
    Hour = Ώρα
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ορίστηκε σε {1}.
    Collecting  = Συλλογή πληροφοριών διεργασιών συστήματος.
    ParagraphDetail = Οι ακόλουθες ενότητες περιγράφουν τις διεργασίες του συστήματος.
    ParagraphSummary = Ο παρακάτω πίνακας συνοψίζει τις κορυφαίες 5 διεργασίες του συστήματος. Για πιο λεπτομερείς πληροφορίες, ορίστε την τιμή InfoLevel.ProcessInfo σε 2 στο αρχείο διαμόρφωσης της αναφοράς σας. Ταξινομημένες κατά χρήση CPU.
    Heading = Διεργασίες

    Name = Όνομα
    Id = Id
    CPU = CPU (%)
    Memory = Μνήμη (MB)
    Company = Εταιρεία
    Product = Προϊόν
    Unknown = Άγνωστο

    Generating = Δημιουργία διαγράμματος διεργασιών.
    Label = Ιεραρχία διεργασιών
    MainDiagramLabel = Διάγραμμα ιεραρχίας διεργασιών
    Unable = Αδυναμία δημιουργίας διαγράμματος ιεραρχίας διεργασιών.
    MEMUsage = Χρήση μνήμης
    CPUUsage = Χρήση CPU
    Processes = Διεργασίες
    MEMUsageChart = Χρήση μνήμης - Διάγραμμα
    CPUUsageChart = Χρήση CPU - Διάγραμμα
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ορίστηκε σε {1}.
    Collecting  = Συλλογή πληροφοριών ζώνης ώρας συστήματος.
    ParagraphDetail = Οι ακόλουθες ενότητες περιγράφουν τη ζώνη ώρας του συστήματος.
    ParagraphSummary = Ο παρακάτω πίνακας συνοψίζει τη ζώνη ώρας του συστήματος.
    Heading = Ζώνη ώρας

    TimeZone = Ζώνη ώρας
    Id = Id
    DisplayName = Όνομα εμφάνισης
    CurrentTime = Τρέχουσα ώρα
    BaseUTCOffset = Βασική μετατόπιση UTC
    SupportsDaylightSavingTime = Υποστηρίζει θερινή ώρα
    Yes = Ναι
    No = Όχι
    Unknown = Άγνωστο
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ορίστηκε σε {1}.
    Collecting = Συλλογή πληροφοριών χρόνου λειτουργίας συστήματος.
    ParagraphDetail = Οι ακόλουθες ενότητες περιγράφουν τον χρόνο λειτουργίας του συστήματος.
    ParagraphSummary = Ο παρακάτω πίνακας συνοψίζει τον χρόνο λειτουργίας του συστήματος.
    Heading = Χρόνος λειτουργίας

    Uptime = Χρόνος λειτουργίας
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ορίστηκε σε {1}.
    Collecting = Συλλογή πληροφοριών PowerShell Host συστήματος.
    ParagraphDetail = Οι ακόλουθες ενότητες περιγράφουν το PowerShell Host του συστήματος.
    ParagraphSummary = Ο παρακάτω πίνακας συνοψίζει το PowerShell Host του συστήματος.
    Heading = PowerShell Host

    Name = Όνομα
    Version = Έκδοση
    CurrentCulture = Τρέχουσα κουλτούρα
    CurrentUICulture = Τρέχουσα κουλτούρα UI
    DebuggerEnabled = Debugger ενεργοποιημένο
    Yes = Ναι
    No = Όχι
    Unknown = Άγνωστο
'@
}
