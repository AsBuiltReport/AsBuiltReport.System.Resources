# culture = 'th-TH'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ตั้งค่าที่ {1}
    Collecting  = กำลังรวบรวมข้อมูลวันที่ของระบบ
    ParagraphDetail = ส่วนต่อไปนี้อธิบายรายละเอียดวันที่ของระบบ
    ParagraphSummary = ตารางต่อไปนี้สรุปวันที่ของระบบ
    Heading = วันที่

    Date = วันที่
    Hour = ชั่วโมง
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel ตั้งค่าที่ {1}
    Collecting  = กำลังรวบรวมข้อมูลกระบวนการของระบบ
    ParagraphDetail = ส่วนต่อไปนี้อธิบายรายละเอียดกระบวนการของระบบ
    ParagraphSummary = ตารางต่อไปนี้สรุปกระบวนการของระบบ 5 อันดับแรก สำหรับข้อมูลโดยละเอียดเพิ่มเติม โปรดตั้งค่า InfoLevel.ProcessInfo เป็น 2 ในไฟล์การกำหนดค่ารายงานของคุณ เรียงลำดับตามการใช้งาน CPU
    Heading = กระบวนการ

    Name = ชื่อ
    Id = Id
    CPU = CPU (%)
    Memory = หน่วยความจำ (MB)
    Company = บริษัท
    Product = ผลิตภัณฑ์
    Unknown = ไม่ทราบ

    Generating = กำลังสร้างแผนภาพกระบวนการ
    Label = ลำดับชั้นของกระบวนการ
    MainDiagramLabel = แผนภาพลำดับชั้นของกระบวนการ
    Unable = ไม่สามารถสร้างแผนภาพลำดับชั้นของกระบวนการได้
    MEMUsage = การใช้หน่วยความจำ
    CPUUsage = การใช้ CPU
    Processes = กระบวนการ
    MEMUsageChart = การใช้หน่วยความจำ - แผนภาพ
    CPUUsageChart = การใช้ CPU - แผนภาพ
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ตั้งค่าที่ {1}
    Collecting  = กำลังรวบรวมข้อมูลเขตเวลาของระบบ
    ParagraphDetail = ส่วนต่อไปนี้อธิบายรายละเอียดเขตเวลาของระบบ
    ParagraphSummary = ตารางต่อไปนี้สรุปเขตเวลาของระบบ
    Heading = เขตเวลา

    TimeZone = เขตเวลา
    Id = Id
    DisplayName = ชื่อที่แสดง
    CurrentTime = เวลาปัจจุบัน
    BaseUTCOffset = ค่าชดเชย UTC พื้นฐาน
    SupportsDaylightSavingTime = รองรับเวลาออมแสง
    Yes = ใช่
    No = ไม่ใช่
    Unknown = ไม่ทราบ
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ตั้งค่าที่ {1}
    Collecting = กำลังรวบรวมข้อมูลเวลาทำงานของระบบ
    ParagraphDetail = ส่วนต่อไปนี้อธิบายรายละเอียดเวลาทำงานของระบบ
    ParagraphSummary = ตารางต่อไปนี้สรุปเวลาทำงานของระบบ
    Heading = เวลาทำงาน

    Uptime = เวลาทำงาน
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel ตั้งค่าที่ {1}
    Collecting = กำลังรวบรวมข้อมูล PowerShell Host ของระบบ
    ParagraphDetail = ส่วนต่อไปนี้อธิบายรายละเอียด PowerShell Host ของระบบ
    ParagraphSummary = ตารางต่อไปนี้สรุป PowerShell Host ของระบบ
    Heading = PowerShell Host

    Name = ชื่อ
    Version = เวอร์ชัน
    CurrentCulture = วัฒนธรรมปัจจุบัน
    CurrentUICulture = วัฒนธรรม UI ปัจจุบัน
    DebuggerEnabled = เปิดใช้งานตัวดีบั๊ก
    Yes = ใช่
    No = ไม่ใช่
    Unknown = ไม่ทราบ
'@
}
