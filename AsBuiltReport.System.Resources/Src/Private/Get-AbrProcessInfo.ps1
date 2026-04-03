
function Get-AbrProcessInfo {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system process information.
    .DESCRIPTION
        Collects the top 5 CPU-consuming processes running on the local system using
        Get-Process, sorted in descending order by CPU time. For each process the following
        fields are captured:

            - Name       : The process executable name (first token, without arguments).
            - Id         : The operating system process identifier (PID).
            - CPU (%)    : Cumulative CPU time rounded to the nearest second.
            - Memory (MB): Working set memory rounded to the nearest megabyte.
            - Company    : The company name embedded in the executable metadata, if available.
            - Product    : The product name embedded in the executable metadata, if available.

        After the tabular data, two bar charts are generated (CPU usage and Memory usage) using
        the AsBuiltReport.Chart module's New-BarChart cmdlet. Finally, a process hierarchy
        diagram is produced by calling Get-AbrProcessDiagram and exported via Export-AbrDiagram.

        The level of detail in the output is controlled by the InfoLevel.ProcessInfo setting
        in the report configuration JSON:

            0 - Disabled. The section is skipped entirely.
            1 - Summary. A compact table of all top-5 processes with key columns only.
            2 - Detailed. A per-process subsection with a full list-style table.

        Localization is handled through the $reportTranslate variable, which is populated by
        AsBuiltReport.Core from the appropriate Language/*.psd1 file.
    .INPUTS
        None. This function does not accept pipeline input. It reads from script-scoped
        variables ($InfoLevel, $reportTranslate, $Report, $System) that are set by the
        AsBuiltReport framework before this function is called.
    .OUTPUTS
        None. Output is written directly to the PScribo document object via Section, Table,
        Paragraph, BlankLine, and Image cmdlets.
    .EXAMPLE
        # This function is called automatically by Invoke-AsBuiltReport.System.Resources.
        # It is not designed to be called directly by end users.
        Get-AbrProcessInfo
    .NOTES
        Version:        0.1.3
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
        # Narrow the translation lookup to the GetAbrProcessInfo section of the language data.
        $reportTranslate = $reportTranslate.GetAbrProcessInfo
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'ProcessInfo', $($InfoLevel.ProcessInfo))
    }

    process {
        try {
            if ($InfoLevel.ProcessInfo -gt 0) {
                # Retrieve the top 5 processes sorted by descending CPU time.
                $SystemProcess = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5
                if ($SystemProcess) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        # Build an array of ordered hashtables so column order is preserved when
                        # converting to PSCustomObjects for the PScribo Table cmdlet.
                        # Translated keys are used throughout so that the table headers match the
                        # active report language regardless of which locale is configured.
                        $SystemProcessInfo = @()
                        foreach ($Process in $SystemProcess) {
                            $InObj = [Ordered]@{
                                # Strip any argument suffix from the process name (split on space, take first token).
                                $($reportTranslate.Name) = $Process.ProcessName.Split(' ')[0]
                                $($reportTranslate.Id) = $Process.Id
                                # Round CPU time to whole seconds; fall back to '--' on error (e.g. access denied).
                                $($reportTranslate.CPU) = & { try { [math]::Round($Process.CPU, 0) } catch { '--' } }
                                # Convert working set bytes to MB; fall back to '--' on error.
                                $($reportTranslate.Memory) = & { try { [math]::Round($Process.WorkingSet / 1MB, 0) } catch { '--' } }
                                $($reportTranslate.Company) = switch ([string]::IsNullOrEmpty($Process.Company)) {
                                    $true { '--' }
                                    $false { $Process.Company }
                                    default { $($reportTranslate.Unknown) }
                                }
                                $($reportTranslate.Product) = switch ([string]::IsNullOrEmpty($Process.Product)) {
                                    $true { '--' }
                                    $false { $Process.Product }
                                    default { $($reportTranslate.Unknown) }
                                }
                            }
                            $SystemProcessInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.ProcessInfo -ge 2) {
                            # InfoLevel 2: render each process as its own subsection with a list-style table.
                            Paragraph $reportTranslate.ParagraphDetail
                            foreach ($Process in $SystemProcessInfo) {
                                # Use the translated Name key to read the process name property, ensuring
                                # the section heading is correct in all supported locales.
                                Section -Style NOTOCHeading4 -ExcludeFromTOC "$($Process.($reportTranslate.Name))" {
                                    $TableParams = @{
                                        Name = "$($reportTranslate.Heading) - $($Process.($reportTranslate.Name))"
                                        List = $true
                                        ColumnWidths = 40, 60
                                    }
                                    if ($Report.ShowTableCaptions) {
                                        $TableParams['Caption'] = "- $($TableParams.Name)"
                                    }
                                    $Process | Table @TableParams
                                }
                            }
                        } else {
                            # InfoLevel 1: render a single compact table with the most useful columns only.
                            Paragraph $reportTranslate.ParagraphSummary
                            BlankLine
                            $TableParams = @{
                                Name = "$($reportTranslate.Heading) - $($System)"
                                List = $false
                                Columns = $($reportTranslate.Name), $($reportTranslate.Id), $($reportTranslate.CPU), $($reportTranslate.Memory)
                                ColumnWidths = 25, 25, 25, 25
                            }
                            if ($Report.ShowTableCaptions) {
                                $TableParams['Caption'] = "- $($TableParams.Name)"
                            }
                            $SystemProcessInfo | Table @TableParams
                        }
                        # Generate a bar chart showing CPU usage for the top 5 processes.
                        try {
                            $Chart = New-BarChart -Values $SystemProcessInfo.$($reportTranslate.CPU) -Labels $SystemProcessInfo.$($reportTranslate.Name) -Title $reportTranslate.CPUUsage -EnableLegend -LegendOrientation Horizontal -LegendAlignment UpperCenter -Width 600 -Height 600 -Format base64 -LabelYAxis $($reportTranslate.CPU) -LabelXAxis $($reportTranslate.Processes) -TitleFontSize 20 -TitleFontBold -AreaOrientation Vertical -EnableCustomColorPalette -CustomColorPalette @('#395879', '#59779a', '#7b98bc', '#9dbae0', '#c0ddff') -AxesMarginsTop 0.5
                            if ($Chart) {
                                Section -Style Heading3 $reportTranslate.CPUUsageChart {
                                    Image -Text $reportTranslate.CPUUsageChart -Align 'Center' -Percent 70 -Base64 $Chart
                                }
                            }
                        } catch {
                            Write-PScriboMessage -IsWarning $_.Exception.Message
                        }
                        # Generate a bar chart showing memory usage for the top 5 processes.
                        try {
                            $Chart = New-BarChart -Values $SystemProcessInfo.$($reportTranslate.Memory) -Labels $SystemProcessInfo.$($reportTranslate.Name) -Title $reportTranslate.MEMUsage -EnableLegend -LegendOrientation Horizontal -LegendAlignment UpperCenter -Width 600 -Height 600 -Format base64 -LabelYAxis $($reportTranslate.Memory) -LabelXAxis $($reportTranslate.Processes) -TitleFontSize 20 -TitleFontBold -AreaOrientation Vertical -EnableCustomColorPalette -CustomColorPalette @('#395879', '#59779a', '#7b98bc', '#9dbae0', '#c0ddff') -AxesMarginsTop 0.5
                            if ($Chart) {
                                Section -Style Heading3 $reportTranslate.MEMUsageChart {
                                    Image -Text $reportTranslate.MEMUsageChart -Align 'Center' -Percent 70 -Base64 $Chart
                                }
                            }
                        } catch {
                            Write-PScriboMessage -IsWarning $_.Exception.Message
                        }
                        # Generate and embed the process hierarchy diagram.
                        try {
                            $ProcessDiagram = Get-AbrProcessDiagram
                            if ($ProcessDiagram) {
                                Export-AbrDiagram -DiagramObject $ProcessDiagram -MainDiagramLabel $reportTranslate.MainDiagramLabel -Filename 'AsBuiltReport.System.Resources.ProcessDiagram'
                            } else {
                                Write-PScriboMessage -IsWarning $reportTranslate.Unable
                            }
                        } catch {
                            Write-PScriboMessage -IsWarning $($_.Exception.Message)
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