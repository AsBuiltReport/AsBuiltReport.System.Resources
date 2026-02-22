function Get-AbrProcessDiagram {
    <#
    .SYNOPSIS
        Used by As Built Report to built process diagram
    .DESCRIPTION

    .NOTES
        Version:        0.1.2
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
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'ProcessInfo', $($InfoLevel.ProcessInfo))
        Write-PScriboMessage $($reportTranslate.Generating)
        # Used for DiagramDebug
        if ($Options.EnableDiagramDebug) {
            $EdgeDebug = @{style = 'filled'; color = 'red' }
            $SubGraphDebug = @{style = 'dashed'; color = 'red' }
            $NodeDebug = @{color = 'black'; style = 'red'; shape = 'plain' }
            $NodeDebugEdge = @{color = 'black'; style = 'red'; shape = 'plain' }
            $IconDebug = $true
        } else {
            $EdgeDebug = @{style = 'invis'; color = 'red' }
            $SubGraphDebug = @{style = 'invis'; color = 'gray' }
            $NodeDebug = @{color = 'transparent'; style = 'transparent'; shape = 'point' }
            $NodeDebugEdge = @{color = 'transparent'; style = 'transparent'; shape = 'none' }
            $IconDebug = $false
        }

        if ($Options.DiagramTheme -eq 'Black') {
            $Edgecolor = 'White'
            $Fontcolor = 'White'
        } elseif ($Options.DiagramTheme -eq 'Neon') {
            $Edgecolor = 'gold2'
            $Fontcolor = 'gold2'
        } else {
            $Edgecolor = '#71797E'
            $Fontcolor = '#565656'
        }
    }

    process {
        try {
            $Process = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -Property @{Name = 'Name'; Expression = { "$($_.Name) (Id=$($_.Id))" } } -First 5
            SubGraph ProcessH -Attributes @{Label = $($reportTranslate.Label); fontsize = 22; penwidth = 1.5; labelloc = 't'; style = 'dashed,rounded'; color = 'gray' } {
                Node 'System' -NodeScript { $_ } -Attributes @{shape = 'rectangle'; style = 'filled'; fillcolor = '#EDEDED'; color = '#71797E'; fontcolor = $Fontcolor; penwidth = 1.5; }
                Node $Process.Name -NodeScript { $_ } -Attributes @{shape = 'rectangle'; style = 'filled'; fillcolor = '#EDEDED'; color = '#71797E'; fontcolor = $Fontcolor; penwidth = 1.5; }
                Edge -From 'System' -To $Process.Name -Attributes @{color = $Edgecolor; style = 'dashed'; penwidth = 1.5; }

            }

        } catch {
            Write-PScriboMessage -IsWarning $_.Exception.Message
        }
    }

    end {}

}