# culture = 'tr-TR'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel {1} olarak ayarlandı.
    Collecting  = Sistem tarih bilgileri toplanıyor.
    ParagraphDetail = Aşağıdaki bölümler sistem tarihini detaylandırır.
    ParagraphSummary = Aşağıdaki tablo sistem tarihini özetler.
    Heading = Tarih

    Date = Tarih
    Hour = Saat
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel {1} olarak ayarlandı.
    Collecting  = Sistem işlem bilgileri toplanıyor.
    ParagraphDetail = Aşağıdaki bölümler sistem işlemlerini detaylandırır.
    ParagraphSummary = Aşağıdaki tablo en iyi 5 sistem işlemini özetler. Daha ayrıntılı bilgi için, rapor yapılandırma dosyanızda InfoLevel.ProcessInfo değerini 2 olarak ayarlayın. CPU kullanımına göre sıralanmıştır.
    Heading = İşlemler

    Name = Ad
    Id = Id
    CPU = CPU (%)
    Memory = Bellek (MB)
    Company = Şirket
    Product = Ürün
    Unknown = Bilinmiyor
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel {1} olarak ayarlandı.
    Collecting  = Sistem saat dilimi bilgileri toplanıyor.
    ParagraphDetail = Aşağıdaki bölümler sistem saat dilimini detaylandırır.
    ParagraphSummary = Aşağıdaki tablo sistem saat dilimini özetler.
    Heading = Saat Dilimi

    TimeZone = Saat Dilimi
    Id = Id
    DisplayName = Görünen Ad
    CurrentTime = Geçerli Saat
    BaseUTCOffset = Temel UTC Farkı
    SupportsDaylightSavingTime = Yaz Saati Uygulamasını Destekler
    Yes = Evet
    No = Hayır
    Unknown = Bilinmiyor
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel {1} olarak ayarlandı.
    Collecting = Sistem çalışma süresi bilgileri toplanıyor.
    ParagraphDetail = Aşağıdaki bölümler sistem çalışma süresini detaylandırır.
    ParagraphSummary = Aşağıdaki tablo sistem çalışma süresini özetler.
    Heading = Çalışma Süresi

    Uptime = Çalışma Süresi
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel {1} olarak ayarlandı.
    Collecting = Sistem PowerShell Host bilgileri toplanıyor.
    ParagraphDetail = Aşağıdaki bölümler sistem PowerShell Host'unu detaylandırır.
    ParagraphSummary = Aşağıdaki tablo sistem PowerShell Host'unu özetler.
    Heading = PowerShell Host

    Name = Ad
    Version = Sürüm
    CurrentCulture = Geçerli Kültür
    CurrentUICulture = Geçerli UI Kültürü
    DebuggerEnabled = Hata Ayıklayıcı Etkin
    Yes = Evet
    No = Hayır
    Unknown = Bilinmiyor
'@
}
