# culture = 'ar-SA'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} تم تعيين InfoLevel على {1}.
    Collecting  = جمع معلومات تاريخ النظام.
    ParagraphDetail = تفصل الأقسام التالية تاريخ النظام.
    ParagraphSummary = يلخص الجدول التالي تاريخ النظام.
    Heading = التاريخ

    Date = التاريخ
    Hour = الساعة
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} تم تعيين InfoLevel على {1}.
    Collecting  = جمع معلومات عمليات النظام.
    ParagraphDetail = تفصل الأقسام التالية عمليات النظام.
    ParagraphSummary = يلخص الجدول التالي أهم 10 عمليات للنظام. لمزيد من المعلومات التفصيلية، يرجى تعيين قيمة InfoLevel.ProcessInfo على 2 في ملف تكوين التقرير الخاص بك. مرتبة حسب استخدام CPU.
    Heading = العمليات

    Name = الاسم
    Id = المعرف
    CPU = CPU (%)
    Memory = الذاكرة (MB)
    Company = الشركة
    Product = المنتج
    Unknown = غير معروف
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} تم تعيين InfoLevel على {1}.
    Collecting  = جمع معلومات المنطقة الزمنية للنظام.
    ParagraphDetail = تفصل الأقسام التالية المنطقة الزمنية للنظام.
    ParagraphSummary = يلخص الجدول التالي المنطقة الزمنية للنظام.
    Heading = المنطقة الزمنية

    TimeZone = المنطقة الزمنية
    Id = المعرف
    DisplayName = اسم العرض
    CurrentTime = الوقت الحالي
    BaseUTCOffset = إزاحة UTC الأساسية
    SupportsDaylightSavingTime = يدعم التوقيت الصيفي
    Yes = نعم
    No = لا
    Unknown = غير معروف
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} تم تعيين InfoLevel على {1}.
    Collecting = جمع معلومات وقت تشغيل النظام.
    ParagraphDetail = تفصل الأقسام التالية وقت تشغيل النظام.
    ParagraphSummary = يلخص الجدول التالي وقت تشغيل النظام.
    Heading = وقت التشغيل

    Uptime = وقت التشغيل
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} تم تعيين InfoLevel على {1}.
    Collecting = جمع معلومات مضيف PowerShell للنظام.
    ParagraphDetail = تفصل الأقسام التالية مضيف PowerShell للنظام.
    ParagraphSummary = يلخص الجدول التالي مضيف PowerShell للنظام.
    Heading = مضيف PowerShell

    Name = الاسم
    Version = الإصدار
    CurrentCulture = الثقافة الحالية
    CurrentUICulture = ثقافة UI الحالية
    DebuggerEnabled = المصحح مفعل
    Yes = نعم
    No = لا
    Unknown = غير معروف
'@
}
