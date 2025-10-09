# culture = 'hi-IN'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel {1} पर सेट किया गया।
    Collecting  = सिस्टम तिथि जानकारी एकत्र की जा रही है।
    ParagraphDetail = निम्नलिखित अनुभाग सिस्टम तिथि का विवरण देते हैं।
    ParagraphSummary = निम्नलिखित तालिका सिस्टम तिथि का सारांश प्रस्तुत करती है।
    Heading = तिथि

    Date = तिथि
    Hour = घंटा
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel {1} पर सेट किया गया।
    Collecting  = सिस्टम प्रक्रिया जानकारी एकत्र की जा रही है।
    ParagraphDetail = निम्नलिखित अनुभाग सिस्टम प्रक्रिया का विवरण देते हैं।
    ParagraphSummary = निम्नलिखित तालिका शीर्ष 10 सिस्टम प्रक्रियाओं का सारांश प्रस्तुत करती है। अधिक विस्तृत जानकारी के लिए, कृपया अपनी रिपोर्ट कॉन्फ़िगरेशन फ़ाइल में InfoLevel.ProcessInfo मान को 2 पर सेट करें। CPU उपयोग के अनुसार क्रमबद्ध।
    Heading = प्रक्रियाएं

    Name = नाम
    Id = आईडी
    CPU = CPU (%)
    Memory = मेमोरी (MB)
    Company = कंपनी
    Product = उत्पाद
    Unknown = अज्ञात
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel {1} पर सेट किया गया।
    Collecting  = सिस्टम समय क्षेत्र जानकारी एकत्र की जा रही है।
    ParagraphDetail = निम्नलिखित अनुभाग सिस्टम समय क्षेत्र का विवरण देते हैं।
    ParagraphSummary = निम्नलिखित तालिका सिस्टम समय क्षेत्र का सारांश प्रस्तुत करती है।
    Heading = समय क्षेत्र

    TimeZone = समय क्षेत्र
    Id = आईडी
    DisplayName = प्रदर्शन नाम
    CurrentTime = वर्तमान समय
    BaseUTCOffset = आधार UTC ऑफसेट
    SupportsDaylightSavingTime = डेलाइट सेविंग समय का समर्थन करता है
    Yes = हां
    No = नहीं
    Unknown = अज्ञात
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel {1} पर सेट किया गया।
    Collecting = सिस्टम अपटाइम जानकारी एकत्र की जा रही है।
    ParagraphDetail = निम्नलिखित अनुभाग सिस्टम अपटाइम का विवरण देते हैं।
    ParagraphSummary = निम्नलिखित तालिका सिस्टम अपटाइम का सारांश प्रस्तुत करती है।
    Heading = अपटाइम

    Uptime = अपटाइम
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel {1} पर सेट किया गया।
    Collecting = सिस्टम PowerShell Host जानकारी एकत्र की जा रही है।
    ParagraphDetail = निम्नलिखित अनुभाग सिस्टम PowerShell Host का विवरण देते हैं।
    ParagraphSummary = निम्नलिखित तालिका सिस्टम PowerShell Host का सारांश प्रस्तुत करती है।
    Heading = PowerShell Host

    Name = नाम
    Version = संस्करण
    CurrentCulture = वर्तमान संस्कृति
    CurrentUICulture = वर्तमान UI संस्कृति
    DebuggerEnabled = डीबगर सक्षम
    Yes = हां
    No = नहीं
    Unknown = अज्ञात
'@
}
