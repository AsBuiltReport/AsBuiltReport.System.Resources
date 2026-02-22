
function Get-AbrProcessInfo {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system process information
    .DESCRIPTION

    .NOTES
        Version:        0.1.1
        Author:         AsBuiltReport Community
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
    .EXAMPLE

    .LINK

    #>
    [CmdletBinding()]
    param (
    )

    begin {
        $reportTranslate = $reportTranslate.GetAbrProcessInfo
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'ProcessInfo', $($InfoLevel.ProcessInfo))
    }

    process {
        try {
            if ($InfoLevel.ProcessInfo -gt 0) {
                $SystemProcess = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5
                if ($SystemProcess) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        $SystemProcessInfo = @()
                        foreach ($Process in $SystemProcess) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.Name) = $Process.ProcessName
                                $($reportTranslate.Id) = $Process.Id
                                $($reportTranslate.CPU) = & { try { [math]::Round($Process.CPU, 0) } catch { '--' } }
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
                            Paragraph $reportTranslate.ParagraphDetail
                            foreach ($Process in $SystemProcessInfo) {
                                Section -Style NOTOCHeading4 -ExcludeFromTOC "$($Process.($reportTranslate.Name))" {
                                    $TableParams = @{
                                        Name = "$($reportTranslate.Heading) - $($Process.Name)"
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
                    }
                }
            }
        } catch {
            Write-PScriboMessage -IsWarning $($_.Exception.Message)
        }
    }

    end {}
}