# culture = 'vi-VN'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel được đặt ở {1}.
    Collecting  = Đang thu thập thông tin ngày hệ thống.
    ParagraphDetail = Các phần sau mô tả chi tiết ngày hệ thống.
    ParagraphSummary = Bảng sau tóm tắt ngày hệ thống.
    Heading = Ngày

    Date = Ngày
    Hour = Giờ
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel được đặt ở {1}.
    Collecting  = Đang thu thập thông tin tiến trình hệ thống.
    ParagraphDetail = Các phần sau mô tả chi tiết các tiến trình hệ thống.
    ParagraphSummary = Bảng sau tóm tắt 5 tiến trình hệ thống hàng đầu. Để biết thông tin chi tiết hơn, vui lòng đặt giá trị InfoLevel.ProcessInfo thành 2 trong tệp cấu hình báo cáo của bạn. Được sắp xếp theo mức sử dụng CPU.
    Heading = Tiến trình

    Name = Tên
    Id = Id
    CPU = CPU (%)
    Memory = Bộ nhớ (MB)
    Company = Công ty
    Product = Sản phẩm
    Unknown = Không rõ
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel được đặt ở {1}.
    Collecting  = Đang thu thập thông tin múi giờ hệ thống.
    ParagraphDetail = Các phần sau mô tả chi tiết múi giờ hệ thống.
    ParagraphSummary = Bảng sau tóm tắt múi giờ hệ thống.
    Heading = Múi giờ

    TimeZone = Múi giờ
    Id = Id
    DisplayName = Tên hiển thị
    CurrentTime = Giờ hiện tại
    BaseUTCOffset = Độ lệch UTC cơ bản
    SupportsDaylightSavingTime = Hỗ trợ giờ tiết kiệm ánh sáng ban ngày
    Yes = Có
    No = Không
    Unknown = Không rõ
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel được đặt ở {1}.
    Collecting = Đang thu thập thông tin thời gian hoạt động của hệ thống.
    ParagraphDetail = Các phần sau mô tả chi tiết thời gian hoạt động của hệ thống.
    ParagraphSummary = Bảng sau tóm tắt thời gian hoạt động của hệ thống.
    Heading = Thời gian hoạt động

    Uptime = Thời gian hoạt động
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel được đặt ở {1}.
    Collecting = Đang thu thập thông tin PowerShell Host của hệ thống.
    ParagraphDetail = Các phần sau mô tả chi tiết PowerShell Host của hệ thống.
    ParagraphSummary = Bảng sau tóm tắt PowerShell Host của hệ thống.
    Heading = PowerShell Host

    Name = Tên
    Version = Phiên bản
    CurrentCulture = Văn hóa hiện tại
    CurrentUICulture = Văn hóa UI hiện tại
    DebuggerEnabled = Trình gỡ lỗi đã bật
    Yes = Có
    No = Không
    Unknown = Không rõ
'@
}
