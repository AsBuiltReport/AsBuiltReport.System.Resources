function Export-AbrDiagram {
    <#
    .SYNOPSIS
        Used by As Built Report to export diagrams.
    .DESCRIPTION
        Renders and embeds a Graphviz diagram into the active PScribo report section using the
        AsBuiltReport.Diagram module's New-Diagrammer cmdlet. Optionally, the diagram can also
        be saved to disk in one or more formats.

        Behaviour is driven by the Options block of the report configuration JSON:

            EnableDiagrams          - Master switch. When false the function exits immediately.
            DiagramTheme            - 'Black', 'Neon', or 'White' (default). Controls background
                                      and font colours passed to New-Diagrammer.
            DiagramWaterMark        - Text watermark overlaid on the diagram image.
            ExportDiagrams          - When true, saves the diagram to OutputFolderPath on disk.
            ExportDiagramsFormat    - Array of formats to save (e.g. @('png', 'pdf', 'svg')).
                                      Defaults to 'png' if not set.
            EnableDiagramDebug      - When true, passes DraftMode to New-Diagrammer so that
                                      Graphviz debug styling (red borders, visible edges) is
                                      rendered, which is useful for troubleshooting layout.
            EnableDiagramSignature  - When true, adds an author/company signature block.
            SignatureAuthorName     - Author name shown in the signature block.
            SignatureCompanyName    - Company name shown in the signature block.
            EnableDiagramMainLogo   - Controls whether the main logo is shown in the diagram.

        The diagram is always rendered as base64 and embedded in the report via the PScribo
        Image cmdlet. If ExportDiagrams is also enabled the diagram is additionally written to
        disk in the requested format(s) before the base64 pass.
    .PARAMETER DiagramObject
        The Graphviz graph object produced by the diagram builder function (e.g.
        Get-AbrProcessDiagram). This is passed directly to New-Diagrammer as its -InputObject.
    .PARAMETER MainDiagramLabel
        Human-readable label used as the diagram title and as the PScribo Section heading.
        Defaults to 'Change Me' if not specified.
    .PARAMETER FileName
        Base file name (without extension) used when saving the diagram to disk.
        Required when ExportDiagrams is enabled.
    .INPUTS
        None. This function does not accept pipeline input.
    .OUTPUTS
        None. Output is written directly to the PScribo document object via Section and Image
        cmdlets. If ExportDiagrams is enabled, files are also written to OutputFolderPath.
    .EXAMPLE
        # Typically called from within a report section function such as Get-AbrProcessInfo:
        $diagram = Get-AbrProcessDiagram
        Export-AbrDiagram -DiagramObject $diagram -MainDiagramLabel 'Process Hierarchy Diagram' -FileName 'AsBuiltReport.System.Resources'
    .NOTES
        Version:        0.1.3
        Author:         AsBuiltReport Community
        Twitter:        @AsBuiltReport
        Github:         AsBuiltReport
    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '', Scope = 'Function')]

    [CmdletBinding()]
    param (
        # The Graphviz graph object to render. No type constraint is applied because the
        # PSGraph DSL returns a custom object type from the AsBuiltReport.Diagram module.
        $DiagramObject,
        [string] $MainDiagramLabel = 'Change Me',
        [Parameter(Mandatory = $true)]
        [string] $FileName
    )

    begin {
        Write-PScriboMessage -Message "EnableDiagrams set to $($Options.EnableDiagrams)."
    }

    process {
        if ($Options.EnableDiagrams) {
            Write-PScriboMessage -Message "Collecting $MainDiagramLabel diagram"

            # Resolve the icons directory relative to the module root so that icon images can
            # be embedded into diagram nodes by New-Diagrammer.
            $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
            [System.IO.FileInfo]$IconPath = Join-Path -Path $RootPath -ChildPath 'Icons'

            # Build the core parameter set shared by all New-Diagrammer invocations.
            $DiagramParams = @{
                'FileName' = $FileName
                'OutputFolderPath' = $OutputFolderPath
                'MainDiagramLabel' = $MainDiagramLabel
                'MainDiagramLabelFontsize' = 28
                'MainDiagramLabelFontcolor' = '#565656'
                'MainDiagramLabelFontname' = 'Segoe UI Black'
                'IconPath' = $IconPath
                'ImagesObj' = $Images
                'LogoName' = 'AsBuiltReport_LOGO'
                'SignatureLogoName' = 'AsBuiltReport_Signature'
                'WaterMarkText' = $Options.DiagramWaterMark
                'WaterMarkFontOpacity' = 20
                'Direction' = 'top-to-bottom'
                'DisableMainDiagramLogo' = $Options.EnableDiagramMainLogo
            }

            # Apply theme-specific colour overrides on top of the defaults.
            if ($Options.DiagramTheme -eq 'Black') {
                $DiagramParams.add('MainGraphBGColor', 'Black')
                $DiagramParams.add('Edgecolor', 'White')
                $DiagramParams.add('Fontcolor', 'White')
                $DiagramParams.add('NodeFontcolor', 'White')
                $DiagramParams.add('WaterMarkColor', 'White')
            } elseif ($Options.DiagramTheme -eq 'Neon') {
                $DiagramParams.add('MainGraphBGColor', 'grey14')
                $DiagramParams.add('Edgecolor', 'gold2')
                $DiagramParams.add('Fontcolor', 'gold2')
                $DiagramParams.add('NodeFontcolor', 'gold2')
                $DiagramParams.add('WaterMarkColor', '#FFD700')
            } else {
                $DiagramParams.add('WaterMarkColor', '#333333')
            }

            # When ExportDiagrams is enabled, write the diagram to disk in the requested formats.
            if ($Options.ExportDiagrams) {
                if (-not $Options.ExportDiagramsFormat) {
                    $DiagramFormat = 'png'
                } else {
                    $DiagramFormat = $Options.ExportDiagramsFormat
                }
                $DiagramParams.Add('Format', $DiagramFormat)
            } else {
                $DiagramParams.Add('Format', 'base64')
            }

            if ($Options.EnableDiagramDebug) {
                # DraftMode enables Graphviz debug output (e.g. red borders on nodes/edges)
                # to help identify layout problems during development.
                $DiagramParams.Add('DraftMode', $True)
            }

            if ($Options.EnableDiagramSignature) {
                $DiagramParams.Add('Signature', $True)
                $DiagramParams.Add('AuthorName', $Options.SignatureAuthorName)
                $DiagramParams.Add('CompanyName', $Options.SignatureCompanyName)
            }

            if ($Options.ExportDiagrams) {
                try {
                    Write-PScriboMessage -Message "Generating $MainDiagramLabel diagram"
                    $Graph = $DiagramObject
                    if ($Graph) {
                        Write-PScriboMessage -Message "Saving $MainDiagramLabel diagram"
                        $Diagram = New-AbrDiagram @DiagramParams -InputObject $Graph
                        if ($Diagram) {
                            foreach ($OutputFormat in $DiagramFormat) {
                                Write-Information -MessageData "Saved '$($FileName).$($OutputFormat)' diagram to '$($OutputFolderPath)'." -InformationAction Continue
                            }
                        }
                    }
                } catch {
                    Write-PScriboMessage -IsWarning -Message "Unable to export the $MainDiagramLabel Diagram: $($_.Exception.Message)"
                }
            }
            # Always render the diagram as base64 for embedding in the report, regardless of
            # whether ExportDiagrams is enabled. Reuse $DiagramParams but swap the Format.
            try {
                $DiagramParams.Remove('Format')
                $DiagramParams.Add('Format', 'base64')

                $Graph = $DiagramObject
                $Diagram = New-AbrDiagram @DiagramParams -InputObject $Graph
                if ($Diagram) {
                    $BestAspectRatio = Get-BestImageAspectRatio -GraphObj $Diagram -MaxWidth 600 -MaxHeight 600
                    PageBreak
                    Section -Style Heading3 $MainDiagramLabel {
                        Image -Base64 $Diagram -Text "$MainDiagramLabel Diagram" -Width $BestAspectRatio.Width -Height $BestAspectRatio.Height -Align Center
                    }
                }
            } catch {
                Write-PScriboMessage -IsWarning -Message "Unable to generate the $MainDiagramLabel Diagram: $($_.Exception.Message)"
            }
        }
    }

    end {}
}