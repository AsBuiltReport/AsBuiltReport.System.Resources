
function Get-AbrPSHost {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system PowerShell host information.
    .DESCRIPTION
        Queries the current PowerShell host environment using Get-Host and renders the results
        into the report using PScribo cmdlets. The following fields are captured:

            - Name          : The name of the PowerShell host application (e.g. 'ConsoleHost').
            - Version       : The version string of the PowerShell host (e.g. '7.4.0').
            - CurrentCulture   : The language/regional culture for formatting (e.g. 'en-US').
            - CurrentUICulture : The culture used for localized UI messages (e.g. 'en-US').
            - DebuggerEnabled  : Whether the PowerShell debugger is currently enabled.

        The level of detail in the output is controlled by the InfoLevel.PSHost setting in
        the report configuration JSON:

            0 - Disabled. The section is skipped entirely.
            1 - Summary. A single compact table showing key fields for all targets.
            2 - Detailed. A per-target subsection with a full list-style table.

        Localization is handled through the $reportTranslate variable, which is populated by
        AsBuiltReport.Core from the appropriate Language/*.psd1 file.
    .INPUTS
        None. This function does not accept pipeline input. It reads from script-scoped
        variables ($InfoLevel, $reportTranslate, $Report, $System) that are set by the
        AsBuiltReport framework before this function is called.
    .OUTPUTS
        None. Output is written directly to the PScribo document object via Section, Table,
        Paragraph, and BlankLine cmdlets.
    .EXAMPLE
        # This function is called automatically by Invoke-AsBuiltReport.System.Resources.
        # It is not designed to be called directly by end users.
        Get-AbrPSHost
    .NOTES
        Version:        0.1.1
        Author:         AsBuiltReport Community
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    #>
    [CmdletBinding()]
    param (
    )

    begin {
        # Narrow the translation lookup to the GetAbrPSHost section of the language data.
        $reportTranslate = $reportTranslate.GetAbrPSHost
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'PSHost', $($InfoLevel.PSHost))
    }

    process {
        try {
            if ($InfoLevel.PSHost -gt 0) {
                $SystemPSHost = Get-Host
                if ($SystemPSHost) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        # Build an array of ordered hashtables so column order is preserved when
                        # converting to PSCustomObjects for the PScribo Table cmdlet.
                        $SystemPSHostInfo = @()
                        foreach ($PSHost in $SystemPSHost) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.Name) = $PSHost.Name
                                $($reportTranslate.Version) = $PSHost.Version.ToString()
                                $($reportTranslate.CurrentCulture) = $PSHost.CurrentCulture
                                $($reportTranslate.CurrentUICulture) = $PSHost.CurrentUICulture
                                # Convert the boolean Debugger.IsEnabled to a localized Yes/No string.
                                $($reportTranslate.DebuggerEnabled) = switch ($PSHost.Debugger.IsEnabled) {
                                    $true { $($reportTranslate.Yes) }
                                    $false { $($reportTranslate.No) }
                                    default { $($reportTranslate.Unknown) }
                                }
                            }
                            $SystemPSHostInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.PSHost -ge 2) {
                            # InfoLevel 2: render each target as its own subsection with a list-style table.
                            Paragraph $reportTranslate.ParagraphDetail
                            foreach ($PSHostInfo in $SystemPSHostInfo) {
                                Section -Style NOTOCHeading4 -ExcludeFromTOC "$($System)" {
                                    $TableParams = @{
                                        Name = "$($reportTranslate.Heading) - $($System)"
                                        List = $true
                                        ColumnWidths = 40, 60
                                    }
                                    if ($Report.ShowTableCaptions) {
                                        $TableParams['Caption'] = "- $($TableParams.Name)"
                                    }
                                    $PSHostInfo | Table @TableParams
                                }
                            }
                        } else {
                            # InfoLevel 1: render a single compact table across all targets, showing
                            # a subset of the most useful fields.
                            Paragraph $reportTranslate.ParagraphSummary
                            BlankLine
                            $TableParams = @{
                                Name = "$($reportTranslate.Heading) - $($System)"
                                List = $false
                                Columns = $reportTranslate.Name, $reportTranslate.Version, $reportTranslate.CurrentUICulture, $reportTranslate.DebuggerEnabled
                                ColumnWidths = 25, 25, 25, 25
                            }
                            if ($Report.ShowTableCaptions) {
                                $TableParams['Caption'] = "- $($TableParams.Name)"
                            }
                            $SystemPSHostInfo | Table @TableParams
                        }
                    }
                }
            }
        } catch {
            Write-PScriboMessage -IsWarning $($_.Exception.Message)
        }
    }

    end {}
}