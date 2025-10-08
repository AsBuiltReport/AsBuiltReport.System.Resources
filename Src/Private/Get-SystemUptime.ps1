function Get-SystemUptime {
    $operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime
    $Uptime = "$((Get-Date) - ($operatingSystem.LastBootUpTime))"
    return [TimeSpan]$Uptime
}