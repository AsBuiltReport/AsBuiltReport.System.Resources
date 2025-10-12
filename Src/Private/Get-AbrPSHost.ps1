
function Get-AbrPSHost {
    <#
    .SYNOPSIS
        Used by As Built Report to retrieve system PowerShell host information
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
                        $SystemPSHostInfo = @()
                        foreach ($PSHost in $SystemPSHost) {
                            $InObj = [Ordered]@{
                                $($reportTranslate.Name) = $PSHost.Name
                                $($reportTranslate.Version) = $PSHost.Version.ToString()
                                $($reportTranslate.CurrentCulture) = $PSHost.CurrentCulture
                                $($reportTranslate.CurrentUICulture) = $PSHost.CurrentUICulture
                                $($reportTranslate.DebuggerEnabled) = switch ($PSHost.Debugger.IsEnabled) {
                                    $true { $($reportTranslate.Yes) }
                                    $false { $($reportTranslate.No) }
                                    default { $($reportTranslate.Unknown) }
                                }
                            }
                            $SystemPSHostInfo += [PSCustomObject]$InObj
                        }

                        if ($InfoLevel.PSHost -ge 2) {
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