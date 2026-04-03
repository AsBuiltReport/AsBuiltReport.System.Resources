
function Get-AbrUptime {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system uptime information.
    .DESCRIPTION
        Determines how long the system has been running since the last boot and renders the
        result into the report using PScribo cmdlets. The uptime retrieval method varies by
        PowerShell edition:

            PowerShell Core (PSEdition = 'Core'):
                Uses the built-in Get-Uptime cmdlet, available in PowerShell 6 and later on
                Windows, Linux, and macOS.

            Windows PowerShell (PSEdition = 'Desktop'):
                Uses the private Get-SystemUptime helper function, which queries WMI
                (Win32_OperatingSystem.LastBootUpTime) because Get-Uptime is not available
                on PowerShell 5.x.

        Uptime is formatted as 'XhYmZs' (e.g. '03h 45m 12s') for readability.

        The level of detail in the output is controlled by the InfoLevel.Uptime setting in
        the report configuration JSON:

            0 - Disabled. The section is skipped entirely.
            1 - Summary. A single compact table showing Uptime for all targets.
            2 - Detailed. A per-target subsection with a list-style table.

        Localization is handled through the $reportTranslate variable, which is populated by
        AsBuiltReport.Core from the appropriate Language/*.psd1 file.
    .INPUTS
        None. This function does not accept pipeline input. It reads from script-scoped
        variables ($InfoLevel, $reportTranslate, $Report, $System, $PSVersionTable) that are
        set by the AsBuiltReport framework before this function is called.
    .OUTPUTS
        None. Output is written directly to the PScribo document object via Section, Table,
        Paragraph, and BlankLine cmdlets.
    .EXAMPLE
        # This function is called automatically by Invoke-AsBuiltReport.System.Resources.
        # It is not designed to be called directly by end users.
        Get-AbrUptime
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
        # Narrow the translation lookup to the GetAbrUptime section of the language data.
        $reportTranslate = $reportTranslate.GetAbrUptime
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'Uptime', $($InfoLevel.Uptime))
    }

    process {
        try {
            if ($InfoLevel.Uptime -gt 0) {
                # Choose the uptime retrieval method based on the PowerShell edition in use.
                # Get-Uptime is only available in PowerShell Core (6+), so Windows PowerShell
                # (5.x Desktop edition) falls back to the WMI-based Get-SystemUptime helper.
                $SystemUptime = switch ($PSVersionTable.PSEdition) {
                    'Core' { Get-Uptime }
                    'Desktop' { Get-SystemUptime }
                    default { $null }
                }
                if ($SystemUptime) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        # Build an array of ordered hashtables so column order is preserved when
                        # converting to PSCustomObjects for the PScribo Table cmdlet.
                        $SystemUptimeInfo = @()
                        foreach ($Uptime in $SystemUptime) {
                            $InObj = [Ordered]@{
                                # Format the TimeSpan as 'XhYmZs' for a concise, readable output.
                                $($reportTranslate.Uptime) = $Uptime.ToString("hh'h 'mm'm 'ss's'")
                            }
                            $SystemUptimeInfo += [PSCustomObject]$InObj
                        }

                        if ($HealthCheck.Uptime) {
                            $SystemUptimeInfo | Where-Object { $_.$($reportTranslate.Uptime) -lt 24 } | Set-Style -Style Warning -Property $($reportTranslate.Uptime)
                        }

                        if ($InfoLevel.Uptime -ge 2) {
                            # InfoLevel 2: render each target as its own subsection with a list-style table.
                            Paragraph $reportTranslate.ParagraphDetail
                            foreach ($UptimeInfo in $SystemUptimeInfo) {
                                Section -Style NOTOCHeading4 -ExcludeFromTOC "$($System)" {
                                    $TableParams = @{
                                        Name = "$($reportTranslate.Heading) - $($System)"
                                        List = $true
                                        ColumnWidths = 40, 60
                                    }
                                    if ($Report.ShowTableCaptions) {
                                        $TableParams['Caption'] = "- $($TableParams.Name)"
                                    }
                                    $UptimeInfo | Table @TableParams
                                    # If health check is enabled and any target has uptime less than 24 hours, show the warning and corrective actions.
                                    if ($HealthCheck.Uptime -and ($UptimeInfo | Where-Object { $_.$($reportTranslate.Uptime) -lt 24 })) {
                                        Paragraph $reportTranslate.HealthCheck -Bold -Underline
                                        BlankLine
                                        Paragraph {
                                            Text $reportTranslate.CorrectiveActions -Bold
                                            Text $reportTranslate.Downtime
                                        }
                                    }
                                }
                            }
                        } else {
                            # InfoLevel 1: render a single compact table across all targets.
                            Paragraph $reportTranslate.ParagraphSummary
                            BlankLine
                            $TableParams = @{
                                Name = "$($reportTranslate.Heading) - $($System)"
                                List = $false
                                Columns = $reportTranslate.Uptime
                                ColumnWidths = 100
                            }
                            if ($Report.ShowTableCaptions) {
                                $TableParams['Caption'] = "- $($TableParams.Name)"
                            }
                            $SystemUptimeInfo | Table @TableParams
                            # If health check is enabled and any target has uptime less than 24 hours, show the warning and corrective actions.
                            if ($HealthCheck.Uptime -and ($SystemUptimeInfo | Where-Object { $_.$($reportTranslate.Uptime) -lt 24 })) {
                                Paragraph $reportTranslate.HealthCheck -Bold -Underline
                                BlankLine
                                Paragraph {
                                    Text $reportTranslate.CorrectiveActions -Bold
                                    Text $reportTranslate.Downtime
                                }
                            }
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