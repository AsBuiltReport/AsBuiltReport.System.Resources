# culture = 'pt-PT'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel definido para {1}.
    Collecting  = Recolhendo informações de data do sistema.
    ParagraphDetail = As seguintes secções detalham a data do sistema.
    ParagraphSummary = A seguinte tabela resume a data do sistema.
    Heading = Data

    Date = Data
    Hour = Hora
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel definido para {1}.
    Collecting  = Recolhendo informações de processos do sistema.
    ParagraphDetail = As seguintes secções detalham os processos do sistema.
    ParagraphSummary = A seguinte tabela resume os 5 principais processos do sistema. Para informações mais detalhadas, defina o valor InfoLevel.ProcessInfo para 2 no ficheiro de configuração do relatório. Ordenado por utilização de CPU.
    Heading = Processos

    Name = Nome
    Id = Id
    CPU = CPU (%)
    Memory = Memória (MB)
    Company = Empresa
    Product = Produto
    Unknown = Desconhecido
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel definido para {1}.
    Collecting  = Recolhendo informações de fuso horário do sistema.
    ParagraphDetail = As seguintes secções detalham o fuso horário do sistema.
    ParagraphSummary = A seguinte tabela resume o fuso horário do sistema.
    Heading = Fuso horário

    TimeZone = Fuso horário
    Id = Id
    DisplayName = Nome de exibição
    CurrentTime = Hora atual
    BaseUTCOffset = Desvio UTC base
    SupportsDaylightSavingTime = Suporta horário de verão
    Yes = Sim
    No = Não
    Unknown = Desconhecido
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel definido para {1}.
    Collecting = Recolhendo informações de tempo de atividade do sistema.
    ParagraphDetail = As seguintes secções detalham o tempo de atividade do sistema.
    ParagraphSummary = A seguinte tabela resume o tempo de atividade do sistema.
    Heading = Tempo de atividade

    Uptime = Tempo de atividade
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel definido para {1}.
    Collecting = Recolhendo informações do PowerShell Host do sistema.
    ParagraphDetail = As seguintes secções detalham o PowerShell Host do sistema.
    ParagraphSummary = A seguinte tabela resume o PowerShell Host do sistema.
    Heading = PowerShell Host

    Name = Nome
    Version = Versão
    CurrentCulture = Cultura atual
    CurrentUICulture = Cultura UI atual
    DebuggerEnabled = Depurador ativado
    Yes = Sim
    No = Não
    Unknown = Desconhecido
'@
}
