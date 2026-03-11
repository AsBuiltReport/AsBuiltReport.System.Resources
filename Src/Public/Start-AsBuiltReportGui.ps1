function Start-AsBuiltReportGui {
    <#
    .SYNOPSIS
        Launches the Avalonia UI graphical interface for generating a System Resources
        As Built Report.
    .DESCRIPTION
        Opens an interactive window (powered by the AvaloniaUIShell module) that lets
        the user configure and generate a System Resources As Built Report without
        using the command line.

        The GUI exposes the most common New-AsBuiltReport parameters:

            - Target system name
            - Output folder and report name
            - Report language
            - Output format (Html / Word / Text / Excel)
            - Timestamp and HealthCheck toggles
            - Diagram options (Enable, Export, Theme)
            - Per-section InfoLevel (0-2) for Date, TimeZone, Uptime, PSHost,
              and ProcessInfo

        Report generation runs on a background thread, so the window stays fully
        responsive while the report is being produced.

    .NOTES
        Requirements:
            - PowerShell 7.4 or newer  (required by AvaloniaUIShell)
            - AvaloniaUIShell module   (Install-PSResource -Name AvaloniaUIShell)
            - AsBuiltReport.Core 1.6.2 or newer
            - AsBuiltReport.System.Resources module (this module)

        On macOS / Linux run Enable-AUIExecution once after installing AvaloniaUIShell.

    .EXAMPLE
        # Import the module then open the GUI:
        Import-Module AsBuiltReport.System.Resources
        Start-AsBuiltReportGui

    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    .LINK
        https://github.com/mdgrs-mei/AvaloniaUIShell
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param()

    $guiScript = Join-Path $PSScriptRoot '..' 'GUI' 'Invoke-AsBuiltReportGui.ps1'
    $guiScript = [System.IO.Path]::GetFullPath($guiScript)

    if (-not (Test-Path $guiScript)) {
        throw "GUI script not found at expected path: $guiScript"
    }

    if ($PSVersionTable.PSVersion.Major -lt 7 -or
        ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -lt 4)) {
        throw 'Start-AsBuiltReportGui requires PowerShell 7.4 or newer (AvaloniaUIShell requirement).'
    }

    if ($PSCmdlet.ShouldProcess('AsBuiltReport GUI', 'Start')) {
        & $guiScript
    }
}
