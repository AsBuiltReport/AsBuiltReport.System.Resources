
function Get-AbrUptime {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system uptime information
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
        $reportTranslate = $reportTranslate.GetAbrUptime
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'Uptime', $($InfoLevel.Uptime))
    }

    process {
        try {
            if ($InfoLevel.Uptime -gt 0) {
                $SystemUptime = switch ($PSVersionTable.PSEdition) {
                    'Core' { Get-Uptime }
                    'Desktop' { Get-SystemUptime }
                    default { $null }
                }
                if ($SystemUptime) {
                    Write-PScriboMessage $reportTranslate.Collecting
                    Section -Style Heading2 $($reportTranslate.Heading) {
                        $SystemUptimeInfo = @()
                        foreach ($Uptime in $SystemUptime) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.Uptime) = $Uptime.ToString("hh'h 'mm'm 'ss's'")
                            }
                            $SystemUptimeInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.Uptime -ge 2) {
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
                                }
                            }
                        } else {
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