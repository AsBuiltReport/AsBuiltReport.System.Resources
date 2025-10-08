function Get-AbrTimeZone {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system timezone information
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
                        $SystemTimeZoneInfo = @()
                        foreach ($TimeZone in $SystemTimeZone) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.TimeZone) = $TimeZone.Id
                                $($reportTranslate.DisplayName) = $TimeZone.DisplayName
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