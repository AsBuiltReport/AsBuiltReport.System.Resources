function Get-SystemUptime {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve last boot uptime information.
    .DESCRIPTION
        Calculates the system uptime on Windows PowerShell (Desktop edition) by querying the
        Win32_OperatingSystem WMI class for the LastBootUpTime property, then subtracting that
        value from the current date/time to produce a TimeSpan. This helper function is called
        by Get-AbrUptime when running on Windows PowerShell 5.x, which does not have the
        built-in Get-Uptime cmdlet available in PowerShell Core 6+.
    .INPUTS
        None. This function does not accept pipeline input.
    .OUTPUTS
        System.TimeSpan
        Returns a TimeSpan object representing the duration the system has been running since
        the last boot.
    .EXAMPLE
        Get-SystemUptime
        Returns a TimeSpan such as '3.04:12:45.1234567' representing time since last boot.
    .NOTES
        Version:        0.1.1
        Author:         AsBuiltReport Community
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    #>
    [CmdletBinding()]
    [OutputType([TimeSpan])]
    param (
    )

    begin {}

    process {
        # Query the WMI Win32_OperatingSystem class to get the time of the last system boot.
        # This approach is used on Windows PowerShell (Desktop edition) because Get-Uptime is
        # only available in PowerShell Core (PSEdition = 'Core').
        $operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
        # Subtract the last boot time from the current time to calculate the uptime duration.
        return (Get-Date) - $operatingSystem.LastBootUpTime
    }

    end {}
}