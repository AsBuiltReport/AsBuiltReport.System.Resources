function Get-SystemUptime {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve last boot uptime information
    .DESCRIPTION

    .NOTES
        Version:        0.1.1
        Author:         AsBuiltReport Community
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
    .EXAMPLE

    .LINK

    #>
    [CmdletBinding()]
    [OutputType([TimeSpan])]
    param (
    )

    begin {}

    process {
        $operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime
        $Uptime = "$((Get-Date) - ($operatingSystem.LastBootUpTime))"
        return [TimeSpan]$Uptime
    }

    end {}
}