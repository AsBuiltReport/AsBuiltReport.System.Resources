# Copilot Instructions

## Project Overview

This is **AsBuiltReport.System.Resources**, a PowerShell module for the [AsBuiltReport](https://github.com/AsBuiltReport) framework. It generates "As-Built" documentation reports (HTML, Word, Text) describing system resources (date/time, timezone, uptime, PowerShell host info, and top CPU processes) from a local or remote machine.

## Lint & Validation Commands

```powershell
# Validate the module manifest
Test-ModuleManifest .\AsBuiltReport.System.Resources\AsBuiltReport.System.Resources.psd1

# Run PSScriptAnalyzer with project settings
Invoke-ScriptAnalyzer -Path .\AsBuiltReport.System.Resources\Src -Settings .\.github\workflows\PSScriptAnalyzerSettings.psd1 -Recurse

# Run PSScriptAnalyzer on a single file
Invoke-ScriptAnalyzer -Path .\AsBuiltReport.System.Resources\Src\Private\Get-AbrDate.ps1 -Settings .\.github\workflows\PSScriptAnalyzerSettings.psd1
```

No automated test suite exists. PSScriptAnalyzer linting is the CI quality gate, enforced via `.github/workflows/PSScriptAnalyzer.yml` on every push and PR.

## Generating a Report (Manual Testing)

```powershell
# Install prerequisites
Install-Module AsBuiltReport.Core, AsBuiltReport.Chart, AsBuiltReport.Diagram -Force

# Generate a report against localhost
New-AsBuiltReport -Report System.Resources -Target localhost -Format Html -OutputFolderPath C:\Reports -Verbose

# Generate a default config file
New-AsBuiltReportConfig -Report System.Resources -FolderPath C:\Config
```

## Architecture

### Entry Point Flow

```
New-AsBuiltReport (AsBuiltReport.Core framework)
  └─ Invoke-AsBuiltReport.System.Resources   [Src/Public/]
       └─ For each $Target:
            ├─ Get-AbrDate
            ├─ Get-AbrTimeZone
            ├─ Get-AbrUptime
            │    └─ Get-SystemUptime   (WMI fallback for PS 5.1)
            ├─ Get-AbrPSHost
            └─ Get-AbrProcessInfo
                 ├─ Get-AbrProcessDiagram
                 └─ Export-AbrDiagram
```

### Module Loader

`AsBuiltReport.System.Resources.psm1` auto-discovers and dot-sources all `.ps1` files under `Src/Public/` and `Src/Private/`, then exports **both** public and private functions. Private functions must be exported because the AsBuiltReport.Core framework invokes them within its document script block scope.

### Framework-Injected Variables

The AsBuiltReport.Core framework injects these variables into module scope before execution — do not redefine them:

| Variable | Purpose |
|---|---|
| `$ReportConfig` | Parsed JSON configuration object |
| `$InfoLevel` | Per-section detail level (0=disabled, 1=summary, 2=detailed) |
| `$Options` | Feature flags (diagrams, themes, exports) |
| `$Target` | Array of system names to document |
| `$System` | Current target being iterated |
| `$reportTranslate` | Localization string hashtable |
| `$Report` | Report metadata (ShowTableCaptions, etc.) |

### Report Section Pattern

Every section in `Src/Private/` follows the same structure:

1. **Narrow localization scope** — `$reportTranslate = $reportTranslate.GetAbr<Feature>`
2. **Collect data** — use standard PowerShell cmdlets or WMI
3. **Check InfoLevel** — wrap output in `if ($InfoLevel.<Section> -ge 1)` blocks
4. **Render with PScribo** — use `Section`, `Table`, `Paragraph`, `Image` etc.

### PowerShell Edition Detection

Use `$PSVersionTable.PSEdition` to branch between PS 5.1 (Desktop) and PS 7+ (Core):

```powershell
if ($PSVersionTable.PSEdition -eq 'Core') {
    # Use modern cmdlets (e.g., Get-Uptime)
} else {
    # Use WMI / CIM (e.g., Get-SystemUptime helper)
}
```

## Key Conventions

### Naming

- **Private functions:** `Get-Abr<Feature>` (e.g., `Get-AbrDate`, `Get-AbrProcessInfo`)
- **WMI/compatibility helpers:** `Get-System<Task>` (e.g., `Get-SystemUptime`)
- **Public entry point:** `Invoke-AsBuiltReport.System.Resources`
- One function per file; filename matches function name exactly.

### Table Data Pattern

Always build table rows as ordered hashtables promoted to `[PSCustomObject]`, using localized strings as keys:

```powershell
$InObj = [Ordered]@{
    $($reportTranslate.Date) = $Date.ToString('yyyy-MM-dd')
    $($reportTranslate.Hour) = $Date.ToString('HH:mm:ss')
}
$SystemDateInfo += [PSCustomObject]$InObj
```

### Table Rendering Pattern

Always set explicit `ColumnWidths` and conditionally add a caption:

```powershell
$TableParams = @{
    Name         = "Table Name"
    List         = $true
    ColumnWidths = 40, 60
}
if ($Report.ShowTableCaptions) {
    $TableParams['Caption'] = "- $($TableParams.Name)"
}
$data | Table @TableParams
```

### Localization

- Each language lives in `Language/<locale>/SystemResources.psd1` as a nested hashtable.
- Narrow to the relevant subtable at the top of each function: `$reportTranslate = $reportTranslate.GetAbr<Feature>`
- When adding new string keys, add them to **all 26+ language files** under `Language/`.

### Diagram Pipeline

Diagrams use Graphviz via `AsBuiltReport.Diagram`. The pipeline is always:
1. `Get-AbrProcessDiagram` — builds the graph object
2. `Export-AbrDiagram` — calls `New-Diagrammer`, embeds base64 in report, and optionally writes to disk

Diagram features are gated by `$Options.EnableDiagrams`.

### PSScriptAnalyzer Exclusions

The following rules are intentionally suppressed (see `.github/workflows/PSScriptAnalyzerSettings.psd1`):
- `PSUseToExportFieldsInManifest`
- `PSReviewUnusedParameter`
- `PSUseDeclaredVarsMoreThanAssignments`
- `PSAvoidGlobalVars`
- `PSUseSingularNouns`
- `PSAvoidUsingWriteHost`

Do not add `[SuppressMessage]` attributes for these — the settings file handles them globally.

### Code Style

- Indentation: **4 spaces** (no tabs)
- Line length: **115 characters** max
- Opening brace on same line; closing brace on its own line
- PascalCase for all function and parameter names
- Use correct PowerShell cmdlet casing (`Get-ChildItem`, not `get-childitem`)

## Branch & Release Strategy

- Feature branches merge into **`dev`** (never directly into `master`)
- `master` is the release branch; a GitHub release publication triggers the CI pipeline to publish to PowerShell Gallery
- Follow [Keep a Changelog](https://keepachangelog.com/) format for `CHANGELOG.md` entries
