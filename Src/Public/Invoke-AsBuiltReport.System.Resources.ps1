function Invoke-AsBuiltReport.System.Resources {
    <#
    .SYNOPSIS
        PowerShell script to document the configuration of System Resources in Word/HTML/Text formats
    .DESCRIPTION
        Documents the configuration of System Resources in Word/HTML/Text formats using PScribo.
    .NOTES
        Version:        0.1.1
        Author:         AsBuiltReport Organization
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
        Credits:        Iain Brighton (@iainbrighton) - PScribo module

    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Scope = "Script")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "", Scope = "Script")]


    # Do not remove or add to these parameters
    param (
        [String[]] $Target,
        [PSCredential] $Credential
    )

    Write-Host $reportTranslate.InvokeAsBuiltReportSystemResources.Message1
    Write-Host $reportTranslate.InvokeAsBuiltReportSystemResources.Message2
    Write-Host $reportTranslate.InvokeAsBuiltReportSystemResources.Message3
    Write-Host $reportTranslate.InvokeAsBuiltReportSystemResources.Message4
    Write-Host $reportTranslate.InvokeAsBuiltReportSystemResources.Message5

    # Check the version of the dependency modules
    $ModuleArray = @('AsBuiltReport.System.Resources', 'Diagrammer.Core')

    foreach ($Module in $ModuleArray) {
        try {
            $InstalledVersion = Get-Module -ListAvailable -Name $Module -ErrorAction SilentlyContinue | Sort-Object -Property Version -Descending | Select-Object -First 1 -ExpandProperty Version

            if ($InstalledVersion) {
                Write-Host ($reportTranslate.InvokeAsBuiltReportSystemResources.ModuleStatus -f $Module, "v$($InstalledVersion.ToString())")
                $LatestVersion = Find-Module -Name $Module -Repository PSGallery -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Version
                if ($InstalledVersion -lt $LatestVersion) {
                    Write-Host -ForegroundColor Red ($reportTranslate.InvokeAsBuiltReportSystemResources.ModuleAvailable -f $Module, "v$($LatestVersion.ToString())")

                    Write-Host -ForegroundColor Red ($reportTranslate.InvokeAsBuiltReportSystemResources.ModuleUpdateCmd -f $Module)
                }
            }
        } catch {
            Write-PScriboMessage -IsWarning $_.Exception.Message
        }
    }

    # Import Report Configuration
    $Report = $ReportConfig.Report
    $InfoLevel = $ReportConfig.InfoLevel
    $Options = $ReportConfig.Options

    # Used to set values to TitleCase where required
    $TextInfo = (Get-Culture).TextInfo

    # Update/rename the $System variable and build out your code within the ForEach loop. The ForEach loop enables AsBuiltReport to generate an as built configuration against multiple defined targets.

    #region foreach loop
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
