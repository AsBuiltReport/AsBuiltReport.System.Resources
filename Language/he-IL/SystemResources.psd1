# culture = 'he-IL'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel הוגדר ל-{1}.
    Collecting  = איסוף מידע על תאריך המערכת.
    ParagraphDetail = הסעיפים הבאים מפרטים את תאריך המערכת.
    ParagraphSummary = הטבלה הבאה מסכמת את תאריך המערכת.
    Heading = תאריך

    Date = תאריך
    Hour = שעה
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel הוגדר ל-{1}.
    Collecting  = איסוף מידע על תהליכי המערכת.
    ParagraphDetail = הסעיפים הבאים מפרטים את תהליכי המערכת.
    ParagraphSummary = הטבלה הבאה מסכמת את 10 תהליכי המערכת המובילים. למידע מפורט יותר, הגדר את הערך InfoLevel.ProcessInfo ל-2 בקובץ תצורת הדוח שלך. ממוין לפי שימוש ב-CPU.
    Heading = תהליכים

    Name = שם
    Id = מזהה
    CPU = CPU (%)
    Memory = זיכרון (MB)
    Company = חברה
    Product = מוצר
    Unknown = לא ידוע
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel הוגדר ל-{1}.
    Collecting  = איסוף מידע על אזור הזמן של המערכת.
    ParagraphDetail = הסעיפים הבאים מפרטים את אזור הזמן של המערכת.
    ParagraphSummary = הטבלה הבאה מסכמת את אזור הזמן של המערכת.
    Heading = אזור זמן

    TimeZone = אזור זמן
    Id = מזהה
    DisplayName = שם תצוגה
    CurrentTime = זמן נוכחי
    BaseUTCOffset = הסטת UTC בסיסית
    SupportsDaylightSavingTime = תומך בשעון קיץ
    Yes = כן
    No = לא
    Unknown = לא ידוע
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel הוגדר ל-{1}.
    Collecting = איסוף מידע על זמן פעילות המערכת.
    ParagraphDetail = הסעיפים הבאים מפרטים את זמן פעילות המערכת.
    ParagraphSummary = הטבלה הבאה מסכמת את זמן פעילות המערכת.
    Heading = זמן פעילות

    Uptime = זמן פעילות
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel הוגדר ל-{1}.
    Collecting = איסוף מידע על מארח PowerShell של המערכת.
    ParagraphDetail = הסעיפים הבאים מפרטים את מארח PowerShell של המערכת.
    ParagraphSummary = הטבלה הבאה מסכמת את מארח PowerShell של המערכת.
    Heading = מארח PowerShell

    Name = שם
    Version = גרסה
    CurrentCulture = תרבות נוכחית
    CurrentUICulture = תרבות UI נוכחית
    DebuggerEnabled = מנפה שגיאות מופעל
    Yes = כן
    No = לא
    Unknown = לא ידוע
'@
}
