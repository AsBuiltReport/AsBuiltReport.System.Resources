function Invoke-AsBuiltReport.System.Resources {
    <#
    .SYNOPSIS
        PowerShell script to document the configuration of System Resources in Word/HTML/Text formats.
    .DESCRIPTION
        Generates an As Built Report for the local system's resources by orchestrating a
        series of data-collection functions, each of which appends a section to the active
        PScribo document. The following sections are produced (subject to InfoLevel settings):

            - Date        : Current system date and time (Get-AbrDate).
            - TimeZone    : Configured timezone details (Get-AbrTimeZone).
            - Uptime      : Time elapsed since last system boot (Get-AbrUptime).
            - PSHost      : PowerShell host name, version, and culture (Get-AbrPSHost).
            - ProcessInfo : Top 5 CPU-consuming processes with charts and diagram
                            (Get-AbrProcessInfo).

        Each section respects the InfoLevel value (0-2) defined for it in the report
        configuration JSON file:

            0 - Section disabled entirely.
            1 - Summary table only.
            2 - Detailed per-target subsections.

        Report configuration is read from $ReportConfig (populated by AsBuiltReport.Core)
        and split into:
            $Report     - General report metadata (ShowTableCaptions, ShowTableOfContents, etc.).
            $InfoLevel  - Granularity settings for each section.
            $Options    - Feature flags (EnableDiagrams, DiagramTheme, ExportDiagrams, etc.).

        The $Target parameter accepts one or more system names. Each name is used as a
        Heading1 section label. In this proof-of-concept module, data is always collected
        from the local machine regardless of the target value.
    .PARAMETER Target
        One or more target system names. Each name becomes a top-level Heading1 section in
        the report. The value is typically the hostname but can be any descriptive string.
        Provided by the AsBuiltReport.Core framework at report generation time.
    .PARAMETER Credential
        A PSCredential object for authenticating to remote systems. Included for framework
        compatibility; not currently used as this module collects data from the local machine.
    .INPUTS
        None. Parameters are supplied by the AsBuiltReport.Core framework when
        New-AsBuiltReport is invoked.
    .OUTPUTS
        None. All output is written to the PScribo document object managed by
        AsBuiltReport.Core, which then renders it to the chosen output format.
    .EXAMPLE
        # Generate a report for the local machine using the default JSON configuration:
        New-AsBuiltReport -Report System.Resources -Target 'localhost' -OutputFolderPath 'C:\Reports'
    .EXAMPLE
        # Generate a Word document with a custom report name:
        New-AsBuiltReport -Report System.Resources -Target $env:COMPUTERNAME -Format Word -OutputFolderPath 'C:\Reports' -ReportConfigFilePath 'C:\Configs\MyReport.json'
    .NOTES
        Version:        0.1.2
        Author:         AsBuiltReport Community
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
        Credits:        Iain Brighton (@iainbrighton) - PScribo module

    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Scope = 'function')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '', Scope = 'function')]


    # Do not remove or add to these parameters
    [CmdletBinding()]
    param (
        [String[]] $Target,
        [PSCredential] $Credential
    )

    Write-ReportModuleInfo -ModuleName 'System.Resources'

    # Import Report Configuration
    $Report = $ReportConfig.Report
    $InfoLevel = $ReportConfig.InfoLevel
    $Options = $ReportConfig.Options

    # Used to set values to TitleCase where required
    $TextInfo = (Get-Culture).TextInfo

    # Map logical icon names to their physical PNG filenames in the module's 'icons' folder.
    # These are used by the diagram builder functions via the $Images variable.
    $script:Images = @{
        'AsBuiltReport_LOGO' = 'AsBuiltReport_Logo.png'
        'AsBuiltReport_Signature' = 'AsBuiltReport_Signature.png'
        'Abr_LOGO_Footer' = 'AsBuiltReport.png'
        'Process' = 'Process.png'
    }

    #region foreach loop
    # Iterate over each target system. Each target produces a top-level Heading1 section.
    # Note: in the current implementation all data is collected from the local machine;
    # the $System variable is used for report labelling purposes only.
    foreach ($System in $Target) {
        Section -Style Heading1 "$($System.ToUpper())" {
            Get-AbrDate
            Get-AbrTimeZone
            Get-AbrUptime
            Get-AbrPSHost
            Get-AbrProcessInfo
        }
    }
    #endregion foreach loop
}
