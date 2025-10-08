# culture = 'es-ES'
@{

    InvokeAsBuiltReportSystemResources = ConvertFrom-StringData @'
    Message1 = - Por favor, consulte el sitio web de GitHub de AsBuiltReport.System.Resources para obtener información más detallada sobre este proyecto.
    Message2 = - No olvide actualizar su archivo de configuración del informe después de cada nueva versión: https://www.asbuiltreport.com/user-guide/new-asbuiltreportconfig/
    Message3 = - Documentación: https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    Message4 = - Reporte de problemas o errores: https://github.com/AsBuiltReport/AsBuiltReport.System.Resources/issues
    Message5 = - Este proyecto es mantenido por la comunidad y no cuenta con patrocinio de Microsoft/*Linux/MacOS, sus empleados o cualquiera de sus afiliados.

    ModuleStatus = - El módulo {0} {1} está actualmente instalado.
    ModuleAvailable = - El módulo {0} {1} está disponible.
    ModuleUpdateCmd = - Ejecute 'Update-Module -Name {0} -Force' para instalar la última versión.

'@

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel configurado en {1}.
    Collecting  = Recopilando información de la fecha del sistema.
    ParagraphDetail = Las siguientes sección detalla la fecha del sistema.
    ParagraphSummary = La siguiente tabla resume la fecha del sistema.
    Heading = Fecha
    Date = Fecha
    Hour = Hora
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel configurado en {1}.
    Collecting  = Recopilando información del proceso del sistema.
    ParagraphDetail = Las siguientes sección detalla el proceso del sistema.
    ParagraphSummary = La siguiente tabla resume los 10 principales procesos del sistema. Para obtener información más detallada, establezca el valor de InfoLevel.ProcessInfo en 2 en su archivo de configuración del informe. Ordenado por uso de CPU.
    Heading = Procesos
    Name = Nombre
    Id = Id
    CPU = CPU (%)
    Memory = Memoria (MB)
    Company = Compañía
    Product = Producto
    Unknown = Desconocido
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel configurado en {1}.
    Collecting  = Recopilando información de la zona horaria del sistema.
    ParagraphDetail = Las siguientes sección detalla la zona horaria del sistema.
    ParagraphSummary = La siguiente tabla resume la zona horaria del sistema.
    Heading = Zona Horaria

    TimeZone = Zona Horaria
    Id = Id
    DisplayName = Nombre
    CurrentTime = Hora actual
    BaseUTCOffset = Desfase UTC base
    SupportsDaylightSavingTime = Soporta horario de verano
    Yes = Sí
    No = No
    Unknown = Desconocido
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel configurado en {1}.
    Collecting  = Recopilando información del tiempo de actividad del sistema.
    ParagraphDetail = Las siguientes sección detalla el tiempo de actividad del sistema.
    ParagraphSummary = La siguiente tabla resume el tiempo de actividad del sistema.
    Heading = Tiempo de Actividad

    Uptime = Tiempo de Actividad
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel configurado en {1}.
    Collecting = Recopilando información del PowerShell Host del sistema.
    ParagraphDetail = Las siguientes sección detalla el PowerShell Host del sistema.
    ParagraphSummary = La siguiente tabla resume el PowerShell Host del sistema.
    Heading = PowerShell Host

    Name = Nombre
    Version = Versión
    CurrentCulture = Cultura Actual
    CurrentUICulture = Cultura UI Actual
    DebuggerEnabled = Depurador Habilitado
    Yes = Sí
    No = No
    Unknown = Desconocido
'@
}