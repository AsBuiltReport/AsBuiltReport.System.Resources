# culture = 'ru-RU'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel установлен на {1}.
    Collecting  = Сбор информации о дате системы.
    ParagraphDetail = В следующих разделах подробно описывается дата системы.
    ParagraphSummary = В следующей таблице представлена сводка по дате системы.
    Heading = Дата

    Date = Дата
    Hour = Час
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel установлен на {1}.
    Collecting  = Сбор информации о процессах системы.
    ParagraphDetail = В следующих разделах подробно описываются процессы системы.
    ParagraphSummary = В следующей таблице представлены топ-10 процессов системы. Для получения более подробной информации установите значение InfoLevel.ProcessInfo равным 2 в файле конфигурации отчета. Отсортировано по использованию CPU.
    Heading = Процессы

    Name = Имя
    Id = Id
    CPU = CPU (%)
    Memory = Память (МБ)
    Company = Компания
    Product = Продукт
    Unknown = Неизвестно

    Generating = Генерация диаграммы процессов.
    Label = Иерархия процессов
    MainDiagramLabel = Диаграмма иерархии процессов
    Unable = Не удалось сгенерировать диаграмму иерархии процессов.
    MEMUsage = Использование памяти
    CPUUsage = Использование CPU
    Processes = Процессы
    MEMUsageChart = Использование памяти - Диаграмма
    CPUUsageChart = Использование CPU - Диаграмма
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel установлен на {1}.
    Collecting  = Сбор информации о часовом поясе системы.
    ParagraphDetail = В следующих разделах подробно описывается часовой пояс системы.
    ParagraphSummary = В следующей таблице представлена сводка по часовому поясу системы.
    Heading = Часовой пояс

    TimeZone = Часовой пояс
    Id = Id
    DisplayName = Отображаемое имя
    CurrentTime = Текущее время
    BaseUTCOffset = Базовое смещение UTC
    SupportsDaylightSavingTime = Поддерживает летнее время
    Yes = Да
    No = Нет
    Unknown = Неизвестно
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel установлен на {1}.
    Collecting = Сбор информации о времени работы системы.
    ParagraphDetail = В следующих разделах подробно описывается время работы системы.
    ParagraphSummary = В следующей таблице представлена сводка по времени работы системы.
    Heading = Время работы

    Uptime = Время работы
    HealthCheck = Health Check
    CorrectiveActions = Corrective Actions:
    Downtime = System Uptime is below 24 hours. Review the system logs to identify any events that may have caused the unexpected downtime.
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel установлен на {1}.
    Collecting = Сбор информации о PowerShell Host системы.
    ParagraphDetail = В следующих разделах подробно описывается PowerShell Host системы.
    ParagraphSummary = В следующей таблице представлена сводка по PowerShell Host системы.
    Heading = PowerShell Host

    Name = Имя
    Version = Версия
    CurrentCulture = Текущая культура
    CurrentUICulture = Текущая культура UI
    DebuggerEnabled = Отладчик включен
    Yes = Да
    No = Нет
    Unknown = Неизвестно
'@
}
