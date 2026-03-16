function Get-AbrDate {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve System Date information.
    .DESCRIPTION
        Collects the current system date and time, then formats and renders it into the report
        using PScribo cmdlets (Section, Table, Paragraph). The level of detail in the output
        is controlled by the InfoLevel.Date setting in the report configuration JSON:

            0 - Disabled. The section is skipped entirely.
            1 - Summary. A single compact table showing Date and Hour for all targets.
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
        Get-AbrDate
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
        # Narrow the translation lookup to the GetAbrDate section of the language data.
        $reportTranslate = $reportTranslate.GetAbrDate
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'Date', $($InfoLevel.Date))
    }

    process {
        try {
            if ($InfoLevel.Date -gt 0) {
                $SystemDate = Get-Date
                if ($SystemDate) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        # Build an array of ordered hashtables so column order is preserved when
                        # converting to PSCustomObjects for the PScribo Table cmdlet.
                        $SystemDateInfo = @()
                        foreach ($Date in $SystemDate) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.Date) = $Date.ToString('yyyy-MM-dd')
                                $($reportTranslate.Hour) = $Date.ToString('HH:mm:ss')
                            }
                            $SystemDateInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.Date -ge 2) {
                            # InfoLevel 2: render each target as its own subsection with a list-style table.
                            Paragraph $reportTranslate.ParagraphDetail
                            foreach ($DateInfo in $SystemDateInfo) {
                                Section -Style NOTOCHeading4 -ExcludeFromTOC "$($System)" {
                                    $TableParams = @{
                                        Name = "$($reportTranslate.Heading) - $($System)"
                                        List = $true
                                        ColumnWidths = 40, 60
                                    }
                                    if ($Report.ShowTableCaptions) {
                                        $TableParams['Caption'] = "- $($TableParams.Name)"
                                    }
                                    $DateInfo | Table @TableParams
                                }
                            }
                        } else {
                            # InfoLevel 1: render a single compact table across all targets.
                            Paragraph $reportTranslate.ParagraphSummary
                            BlankLine
                            $TableParams = @{
                                Name = "$($reportTranslate.Heading) - $($System)"
                                List = $false
                                Columns = $($reportTranslate.Date), $($reportTranslate.Hour)
                                ColumnWidths = 50, 50
                            }
                            if ($Report.ShowTableCaptions) {
                                $TableParams['Caption'] = "- $($TableParams.Name)"
                            }
                            $SystemDateInfo | Table @TableParams
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