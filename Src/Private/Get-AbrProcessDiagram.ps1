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
            # Get top 5 CPU consuming processes and build diagram
            $Process = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -Property @{Name = 'Name'; Expression = { "$($_.Name.Split(' ')[0]) (Id=$($_.Id))" } }, @{Name = 'CPU'; Expression = { try { [math]::Round($_.CPU, 0) } catch { '--' } } }, @{Name = 'MEM'; Expression = { try { [math]::Round($_.WorkingSet / 1MB, 0) } catch { '--' } } } -First 5

            # Subgraph is a graphviz element that allows to group nodes together. In this case we are grouping the top 5 processes
            # together in a subgraph called ProcessH. Subgraph is used to create a cluster in the diagram. The cluster is styled with a
            # dashed border and a label. The nodes inside the cluster are the top 5 processes. Each process node has an icon and additional
            # information about CPU and Memory usage. Edges are drawn from the System node to each process node with a dashed line.
            SubGraph ProcessH -Attributes @{Label = $($reportTranslate.Label); fontsize = 28; fontcolor = $Fontcolor; penwidth = 1.5; labelloc = 't'; style = 'dashed,rounded'; color = 'gray' } {

                # Add system node with icon and then add process nodes with icons and additional info.
                # Add-DiaNodeIcon is a custom function that adds an icon to the node. It takes parameters for the name of the node,
                # whether to include debug styling, the type of icon to use, the images object that contains the icons, and the node
                # object to add the icon to. For process nodes, additional info about CPU and Memory usage is added as well.
                Add-DiaNodeIcon -Name 'System' -IconDebug $IconDebug -IconType 'Process' -ImagesObj $Images -NodeObject

                # Add process nodes with icons and additional info about CPU and Memory usage. The process name is simplified to remove extra information.
                $Process | ForEach-Object { Add-DiaNodeIcon -Name $_.Name -IconDebug $IconDebug -IconType 'Process' -ImagesObj $Images -NodeObject -AditionalInfo @{'CPU Usage' = $_.CPU; 'Memory Usage' = $_.MEM } }

                # Edge is a graphviz element that represents a connection between two nodes. In this case, we are adding edges from the System node
                # to each process node. The edges are styled with a dashed line and a specific color based on the diagram theme.
                # The pen width is set to 1.5 for better visibility.
                $Process | ForEach-Object { Edge -From 'System' -To $_.Name -Attributes @{color = $Edgecolor; style = 'dashed'; penwidth = 1.5; } }
            }
        } catch {
            Write-PScriboMessage -IsWarning $_.Exception.Message
        }
    }

    end {}

}