function Get-AbrTimeZone {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system timezone information.
    .DESCRIPTION
        Queries the local system's timezone configuration using the Get-TimeZone cmdlet and
        renders the results into the report using PScribo cmdlets. The following fields are
        captured for each timezone:

            - TimeZone ID (e.g. 'Pacific Standard Time')
            - DisplayName (e.g. '(UTC-08:00) Pacific Time (US & Canada)')
            - Current Time (snapshot of the time when the report is generated)
            - Base UTC Offset (e.g. '-08:00:00')
            - Supports Daylight Saving Time (Yes / No)

        The level of detail in the output is controlled by the InfoLevel.TimeZone setting in
        the report configuration JSON:

            0 - Disabled. The section is skipped entirely.
            1 - Summary. A single compact table showing all fields for all targets.
            2 - Detailed. A per-target subsection with a list-style table.

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
        Get-AbrTimeZone
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
        # Narrow the translation lookup to the GetAbrTimeZone section of the language data.
        $reportTranslate = $reportTranslate.GetAbrTimeZone
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'TimeZone', $($InfoLevel.TimeZone))
    }

    process {
        try {
            if ($InfoLevel.TimeZone -gt 0) {
                $SystemTimeZone = Get-TimeZone
                if ($SystemTimeZone) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        # Build an array of ordered hashtables so column order is preserved when
                        # converting to PSCustomObjects for the PScribo Table cmdlet.
                        $SystemTimeZoneInfo = @()
                        foreach ($TimeZone in $SystemTimeZone) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.TimeZone) = $TimeZone.Id
                                $($reportTranslate.DisplayName) = $TimeZone.DisplayName
                                # Capture the current time at report-generation time for reference.
                                $($reportTranslate.CurrentTime) = Get-Date -DisplayHint Time
                                $($reportTranslate.BaseUTCOffset) = $TimeZone.BaseUtcOffset
                                $($reportTranslate.SupportsDaylightSavingTime) = switch ($TimeZone.SupportsDaylightSavingTime) {
                                    $true { $($reportTranslate.Yes) }
                                    $false { $($reportTranslate.No) }
                                    default { $($reportTranslate.Unknown) }
                                }
                            }
                            $SystemTimeZoneInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.TimeZone -ge 2) {
                            # InfoLevel 2: render each target as its own subsection with a list-style table.
                            Paragraph $reportTranslate.ParagraphDetail
                            foreach ($TimeZoneInfo in $SystemTimeZoneInfo) {
                                Section -Style NOTOCHeading4 -ExcludeFromTOC "$($System)" {
                                    $TableParams = @{
                                        Name = "$($reportTranslate.Heading) - $($System)"
                                        List = $true
                                        ColumnWidths = 40, 60
                                    }
                                    if ($Report.ShowTableCaptions) {
                                        $TableParams['Caption'] = "- $($TableParams.Name)"
                                    }
                                    $TimeZoneInfo | Table @TableParams
                                }
                            }
                        } else {
                            # InfoLevel 1: render a single compact table across all targets.
                            Paragraph $reportTranslate.ParagraphSummary
                            BlankLine
                            $TableParams = @{
                                Name = "$($reportTranslate.Heading) - $($System)"
                                List = $false
                                Columns = $reportTranslate.TimeZone, $reportTranslate.DisplayName, $reportTranslate.CurrentTime, $reportTranslate.BaseUTCOffset, $reportTranslate.SupportsDaylightSavingTime
                                ColumnWidths = 20, 20, 20, 20, 20
                            }
                            if ($Report.ShowTableCaptions) {
                                $TableParams['Caption'] = "- $($TableParams.Name)"
                            }
                            $SystemTimeZoneInfo | Table @TableParams
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