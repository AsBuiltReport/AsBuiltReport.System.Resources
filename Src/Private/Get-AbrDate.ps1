function Get-AbrDate {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve System Date information
    .DESCRIPTION

    .NOTES
        Version:        0.1.1
        Author:         AsBuiltReport Organization
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
    .EXAMPLE

    .LINK

    #>
    [CmdletBinding()]
    param (
    )

    begin {
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
                        $SystemDateInfo = @()
                        foreach ($Date in $SystemDate) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.Date) = $Date.ToString('yyyy-MM-dd')
                                $($reportTranslate.Hour) = $Date.ToString('HH:mm:ss')
                            }
                            $SystemDateInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.Date -ge 2) {
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