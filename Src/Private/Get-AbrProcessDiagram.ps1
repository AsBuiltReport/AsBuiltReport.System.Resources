function Get-AbrProcessDiagram {
    <#
    .SYNOPSIS
        Used by As Built Report to build a process hierarchy diagram.
    .DESCRIPTION
        Builds a Graphviz-based process hierarchy diagram showing the top 5 CPU-consuming
        processes and their relationship to the host system. The diagram is constructed using
        the AsBuiltReport.Diagram module's PSGraph DSL (SubGraph, Add-DiaNodeIcon, Edge).

        The diagram structure:
            - A single SubGraph named 'ProcessH' acts as the cluster container.
            - A 'System' node represents the host machine.
            - Five process nodes (one per top-5 process) show CPU and Memory usage as
              additional node attributes.
            - Dashed edges connect the 'System' node to each process node.

        Colour and style are determined by the DiagramTheme option:
            Black  - Dark background, white labels and edges.
            Neon   - Dark grey background, gold labels and edges.
            White  - Default; light-coloured edges and labels.

        When EnableDiagramDebug is true, debug styling (red dashed borders, visible edges)
        is applied to all graph elements to help troubleshoot layout issues.

        This function returns the resulting Graphviz graph object, which is then passed to
        Export-AbrDiagram for rendering and embedding into the report.
    .INPUTS
        None. This function does not accept pipeline input. It reads from script-scoped
        variables ($Options, $reportTranslate, $Images) that are set by the AsBuiltReport
        framework before this function is called.
    .OUTPUTS
        System.Object
        Returns the Graphviz SubGraph object produced by the PSGraph DSL. The caller
        (Get-AbrProcessInfo) passes this object to Export-AbrDiagram for rendering.
    .EXAMPLE
        # This function is called automatically by Get-AbrProcessInfo.
        # It is not designed to be called directly by end users.
        $diagram = Get-AbrProcessDiagram
        Export-AbrDiagram -DiagramObject $diagram -MainDiagramLabel 'Process Hierarchy Diagram' -FileName 'ProcessDiagram'
    .NOTES
        Version:        0.1.2
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
        Write-PScriboMessage ($($reportTranslate.InfoLevel) -f 'ProcessInfo', $($InfoLevel.ProcessInfo))
        Write-PScriboMessage $($reportTranslate.Generating)
        # Configure debug styling when EnableDiagramDebug is enabled. In debug mode, edges and
        # subgraph borders are drawn in red so layout issues are easy to spot. In normal mode,
        # these elements are made invisible (style = 'invis') so they do not appear in the
        # final diagram output.
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

        # Set the edge and font colours based on the chosen diagram theme.
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
            # Retrieve the top 5 CPU-consuming processes and project the properties needed for
            # diagram node labels. CPU time is rounded to whole seconds; memory is in MB.
            $Process = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -Property @{Name = 'Name'; Expression = { "$($_.Name.Split(' ')[0]) (Id=$($_.Id))" } }, @{Name = 'CPU'; Expression = { try { [math]::Round($_.CPU, 0) } catch { '--' } } }, @{Name = 'MEM'; Expression = { try { [math]::Round($_.WorkingSet / 1MB, 0) } catch { '--' } } } -First 5

            # SubGraph is a Graphviz element that groups related nodes inside a bordered cluster.
            # Here the cluster contains the System node and the top 5 process nodes.
            # Attributes control the cluster border style, label, font, and colour.
            SubGraph ProcessH -Attributes @{Label = $($reportTranslate.Label); fontsize = 28; fontcolor = $Fontcolor; penwidth = 1.5; labelloc = 't'; style = 'dashed,rounded'; color = 'gray' } {

                # Add the System node to the diagram. Add-DiaNodeIcon is a helper from the
                # AsBuiltReport.Diagram module that renders a node with an icon image sourced
                # from the $Images hashtable.
                Add-DiaNodeIcon -Name 'System' -IconDebug $IconDebug -IconType 'Process' -ImagesObj $Images -NodeObject

                # Add one node per top-5 process. Each node shows the process name (including PID)
                # as well as additional info attributes for CPU and Memory usage.
                $Process | ForEach-Object { Add-DiaNodeIcon -Name $_.Name -IconDebug $IconDebug -IconType 'Process' -ImagesObj $Images -NodeObject -AditionalInfo @{'CPU Usage' = $_.CPU; 'Memory Usage' = $_.MEM } }

                # Draw a dashed edge from the System node to each process node to represent the
                # parent-child relationship. Edge colour and width follow the active theme.
                $Process | ForEach-Object { Edge -From 'System' -To $_.Name -Attributes @{color = $Edgecolor; style = 'dashed'; penwidth = 1.5; } }
            }
        } catch {
            Write-PScriboMessage -IsWarning $_.Exception.Message
        }
    }

    end {}

}