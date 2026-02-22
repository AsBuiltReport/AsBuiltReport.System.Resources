function Invoke-AsBuiltReport.System.Resources {
    <#
    .SYNOPSIS
        PowerShell script to document the configuration of System Resources in Word/HTML/Text formats
    .DESCRIPTION
        Documents the configuration of System Resources in Word/HTML/Text formats using PScribo.
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

    # Import Translated Strings
    $LocalizedData = $reportTranslate.InvokeAsBuiltReportSystemResources

    # Used to set values to TitleCase where required
    $TextInfo = (Get-Culture).TextInfo

    # Update/rename the $System variable and build out your code within the ForEach loop. The ForEach loop enables AsBuiltReport to generate an as built configuration against multiple defined targets.

    $script:Images = @{
        'AsBuiltReport_LOGO' = 'AsBuiltReport_Logo.png'
        'AsBuiltReport_Signature' = 'AsBuiltReport_Signature.png'
        'Abr_LOGO_Footer' = 'AsBuiltReport.png'
    }

    #region foreach loop
    foreach ($System in $Target) {
        Section -Style Heading1 "$($System.ToUpper())" {
            Get-AbrDate
            Get-AbrTimeZone
            Get-AbrUptime
            Get-AbrPSHost
            Get-AbrProcessInfo
            $ProcessDiagram = Get-AbrProcessDiagram
            if ($ProcessDiagram) {
                Export-AbrDiagram -DiagramObject $ProcessDiagram -MainDiagramLabel $LocalizedData.MainDiagramLabel -FileName 'AsBuiltReport.System.Resources.Cluster'
            } else {
                Write-PScriboMessage -IsWarning $LocalizedData.Unable
            }
        }

    }
    #endregion foreach loop
}
