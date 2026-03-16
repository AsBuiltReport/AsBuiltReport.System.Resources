<#
.SYNOPSIS
    Graphical launcher for the System Resources As Built Report.
.DESCRIPTION
    Presents an Avalonia UI window (via the AvaloniaUIShell module) that lets the user
    configure every common New-AsBuiltReport parameter through a point-and-click
    interface and then generate the report without touching the command line.

    Sections of the GUI:

        Report Configuration  - Target, Output Folder, Report Name, Language,
                                AsBuiltReport Config File (optional)
        Output Formats        - Html / Word / Text checkboxes
        Options               - Timestamp, HealthCheck, Diagrams, Export Diagrams,
                                Diagram Theme
        Info Level            - Per-section detail level (0 = Disabled, 1 = Summary,
                                2 = Detailed) for Date, TimeZone, Uptime, PSHost,
                                ProcessInfo
        Generate              - Progress bar + scrollable log; report runs on a
                                background thread so the UI stays responsive.

    An embedded "Generate Config..." wizard mirrors New-AsBuiltConfig: it collects
    Report Author, Company details (Full Name, Short Name, Contact, Email, Phone,
    Address) and optional SMTP/Email settings, then writes a JSON file that can be
    passed to New-AsBuiltReport via -AsBuiltConfigFilePath.

.NOTES
    Requirements:
        - PowerShell 7.4 or newer  (AvaloniaUIShell requirement)
        - AvaloniaUIShell module   (Install-PSResource -Name AvaloniaUIShell)
        - AsBuiltReport.Core 1.6.2 or newer
        - AsBuiltReport.System.Resources module (this module)

    On macOS / Linux run Enable-AUIExecution once after installing AvaloniaUIShell.

.EXAMPLE
    # Launch the GUI from any PowerShell 7 prompt:
    & "$PSScriptRoot\Invoke-AsBuiltReportGui.ps1"

.EXAMPLE
    # Or call the exported wrapper function after importing the module:
    Import-Module AsBuiltReport.System.Resources
    Start-AsBuiltReportGui

.LINK
    https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
.LINK
    https://github.com/mdgrs-mei/AvaloniaUIShell
#>

#Requires -Version 7.4

using namespace AvaloniaUIShell
using namespace AvaloniaUIShell.Avalonia
using namespace AvaloniaUIShell.Avalonia.Controls
using namespace AvaloniaUIShell.Avalonia.Media

# ---------------------------------------------------------------------------
# Guard - AvaloniaUIShell must be available
# ---------------------------------------------------------------------------
if (-not (Get-Module -Name AvaloniaUIShell -ListAvailable)) {
    Write-Error @'
The AvaloniaUIShell module is required to run the GUI.
Install it with:
    Install-PSResource -Name AvaloniaUIShell
On macOS / Linux also run:
    Enable-AUIExecution
'@
    return
}

if (-not (Get-Module -Name AvaloniaUIShell)) {
    Import-Module AvaloniaUIShell -ErrorAction Stop
}

# ---------------------------------------------------------------------------
# Supported language list (matches AsBuiltReport.System.Resources/Language/)
# ---------------------------------------------------------------------------
$LanguageCodes = @(
    'en-US', 'en-GB',
    'ar-SA', 'cs-CZ', 'da-DK', 'de-DE', 'el-GR',
    'es-ES', 'fi-FI', 'fr-FR', 'he-IL', 'hi-IN',
    'hu-HU', 'it-IT', 'ja-JP', 'ko-KR', 'nb-NO',
    'nl-NL', 'pl-PL', 'pt-PT', 'ru-RU', 'sv-SE',
    'th-TH', 'tr-TR', 'vi-VN', 'zh-CN', 'zh-Hans', 'zh-Hant'
)

# ---------------------------------------------------------------------------
# Shared state accessible from the background runspace
# ---------------------------------------------------------------------------
$syncHash = [Hashtable]::Synchronized(@{
        Log = ''
        IsRunning = $false
        CancelRequest = $false
    })

# ---------------------------------------------------------------------------
# Helper: append a line to the log TextBox (thread-safe via AvaloniaUIShell)
# ---------------------------------------------------------------------------
function Add-LogLine {
    param ([string]$Message)
    $ts = (Get-Date).ToString('HH:mm:ss')
    $line = "[$ts] $Message"
    $syncHash.LogBox.Text += "$line`n"
    # Auto-scroll to bottom
    $syncHash.LogScroll.ScrollToEnd()
}

# ===========================================================================
# -- WINDOW ------------------------------------------------------------------
# ===========================================================================
$win = [Window]::new()
$win.Title = 'AsBuiltReport - System Resources'
$win.Width = 680
$win.Height = 740
$win.WindowStartupLocation = 'CenterScreen'
$win.CanMaximize = $false

# ===========================================================================
# -- SECTION HEADER FACTORY --------------------------------------------------
# ===========================================================================
function Get-SectionHeader {
    param ([string]$Text)
    $tb = [TextBlock]::new()
    $tb.Text = $Text
    $tb.FontSize = 13
    $tb.FontWeight = 'SemiBold'
    $tb.Margin = [Thickness]::new(0, 12, 0, 4)
    $tb
}

# ===========================================================================
# -- REPORT CONFIGURATION ----------------------------------------------------
# ===========================================================================

# Target
$lblTarget = [TextBlock]::new(); $lblTarget.Text = 'Target:'
$lblTarget.Width = 130; $lblTarget.VerticalAlignment = 'Center'
$txtTarget = [TextBox]::new()
$txtTarget.Text = [System.Net.Dns]::GetHostName()
$txtTarget.Width = 380
$syncHash.TxtTarget = $txtTarget

$rowTarget = [StackPanel]::new()
$rowTarget.Orientation = 'Horizontal'; $rowTarget.Spacing = 8
$rowTarget.Children.Add($lblTarget)
$rowTarget.Children.Add($txtTarget)

# Output Folder
$lblFolder = [TextBlock]::new(); $lblFolder.Text = 'Output Folder:'
$lblFolder.Width = 130; $lblFolder.VerticalAlignment = 'Center'
$txtFolder = [TextBox]::new()
$txtFolder.Text = [Environment]::GetFolderPath('Desktop')
$txtFolder.Width = 300
$syncHash.TxtFolder = $txtFolder

$btnBrowse = [Button]::new()
$btnBrowse.Content = 'Browse Folder'
$btnBrowse.Width = 120
$btnBrowse.AddClick({
        # Use PowerShell's native folder-picker dialog if available (Windows only);
        # on other platforms fall back to manual text entry.
        if ($IsWindows) {
            try {
                Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
                $dlg = [System.Windows.Forms.FolderBrowserDialog]::new()
                $dlg.Description = 'Select the report output folder'
                $dlg.SelectedPath = $syncHash.TxtFolder.Text
                if ($dlg.ShowDialog() -eq 'OK') {
                    $syncHash.TxtFolder.Text = $dlg.SelectedPath
                }
            } catch {
                Add-LogLine "Folder browser unavailable: $_. Please type the path directly."
            }
        } else {
            Add-LogLine 'Folder browser not available on this platform - type the path directly.'
        }
    })

$rowFolder = [StackPanel]::new()
$rowFolder.Orientation = 'Horizontal'; $rowFolder.Spacing = 8
$rowFolder.Children.Add($lblFolder)
$rowFolder.Children.Add($txtFolder)
$rowFolder.Children.Add($btnBrowse)

# Report Name
$lblName = [TextBlock]::new(); $lblName.Text = 'Report Name:'
$lblName.Width = 130; $lblName.VerticalAlignment = 'Center'
$txtName = [TextBox]::new()
$txtName.Text = 'System Resources As Built Report'
$txtName.Width = 380
$syncHash.TxtName = $txtName

$rowName = [StackPanel]::new()
$rowName.Orientation = 'Horizontal'; $rowName.Spacing = 8
$rowName.Children.Add($lblName)
$rowName.Children.Add($txtName)

# Language
$lblLang = [TextBlock]::new(); $lblLang.Text = 'Language:'
$lblLang.Width = 130; $lblLang.VerticalAlignment = 'Center'
$cbLang = [ComboBox]::new()
$cbLang.Width = 160
foreach ($code in $LanguageCodes) {
    $item = [ComboBoxItem]::new(); $item.Content = $code
    $cbLang.Items.Add($item) | Out-Null
}
$cbLang.SelectedIndex = 0   # en-US
$syncHash.CbLang = $cbLang

$rowLang = [StackPanel]::new()
$rowLang.Orientation = 'Horizontal'; $rowLang.Spacing = 8
$rowLang.Children.Add($lblLang)
$rowLang.Children.Add($cbLang)

# AsBuiltReport Config File (optional - passed via -AsBuiltConfigFilePath)
$lblAbrConfig = [TextBlock]::new(); $lblAbrConfig.Text = 'AsBuiltReport Config:'
$lblAbrConfig.Width = 130; $lblAbrConfig.VerticalAlignment = 'Center'
$txtAbrConfig = [TextBox]::new()
$txtAbrConfig.Width = 220
$txtAbrConfig.Watermark = 'Optional - leave blank to skip'
$syncHash.TxtAbrConfig = $txtAbrConfig

$btnBrowseAbrConfig = [Button]::new()
$btnBrowseAbrConfig.Content = 'Browse'
$btnBrowseAbrConfig.Width = 70
$btnBrowseAbrConfig.AddClick({
    if ($IsWindows) {
        try {
            Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
            $dlg = [System.Windows.Forms.OpenFileDialog]::new()
            $dlg.Title = 'Select AsBuiltReport Config File'
            $dlg.Filter = 'JSON files (*.json)|*.json|All files (*.*)|*.*'
            if ($dlg.ShowDialog() -eq 'OK') {
                $syncHash.TxtAbrConfig.Text = $dlg.FileName
            }
        } catch {
            Add-LogLine "File browser unavailable: $_. Please type the path directly."
        }
    } else {
        Add-LogLine 'File browser not available on this platform - type the path directly.'
    }
})

# "Generate Config..." button - opens a sub-window wizard (mirrors New-AsBuiltConfig)
$btnGenAbrConfig = [Button]::new()
$btnGenAbrConfig.Content = 'Generate Config...'
$btnGenAbrConfig.Width = 120
$btnGenAbrConfig.AddClick({
    # Collect sub-window field values via a synchronized hashtable
    $cfgSync = [Hashtable]::Synchronized(@{})

    $cfgWin = [Window]::new()
    $cfgWin.Title = 'Generate AsBuiltReport Config File'
    $cfgWin.Width = 520
    $cfgWin.Height = 640
    $cfgWin.WindowStartupLocation = 'CenterScreen'
    $cfgWin.CanMaximize = $false

    # ---- inner helper: label + textbox row ----
    $makeCfgRow = {
        param([string]$LabelText, [string]$WatermarkText = '', [string]$DefaultValue = '')
        $lbl = [TextBlock]::new(); $lbl.Text = $LabelText
        $lbl.Width = 130; $lbl.VerticalAlignment = 'Center'
        $txt = [TextBox]::new(); $txt.Width = 310
        if ($WatermarkText) { $txt.Watermark = $WatermarkText }
        if ($DefaultValue)  { $txt.Text = $DefaultValue }
        $row = [StackPanel]::new()
        $row.Orientation = 'Horizontal'; $row.Spacing = 8
        $row.Children.Add($lbl) | Out-Null
        $row.Children.Add($txt) | Out-Null
        return $row, $txt
    }

    # ---- Report info ----
    $rowAuthor,       $txtAuthor       = & $makeCfgRow 'Report Author:' '' ([System.Environment]::UserName)
    $cfgSync.TxtAuthor = $txtAuthor

    # ---- Company ----
    $rowCompanyFull,  $txtCompanyFull  = & $makeCfgRow 'Company Full Name:' 'e.g. Acme Corporation'
    $rowCompanyShort, $txtCompanyShort = & $makeCfgRow 'Company Short Name:' 'e.g. Acme'
    $rowContact,      $txtContact      = & $makeCfgRow 'Contact Name:'
    $rowCompanyEmail, $txtCompanyEmail = & $makeCfgRow 'Contact Email:'
    $rowPhone,        $txtPhone        = & $makeCfgRow 'Phone Number:'
    $rowAddress,      $txtAddress      = & $makeCfgRow 'Address:'
    $cfgSync.TxtCompanyFull  = $txtCompanyFull
    $cfgSync.TxtCompanyShort = $txtCompanyShort
    $cfgSync.TxtContact      = $txtContact
    $cfgSync.TxtCompanyEmail = $txtCompanyEmail
    $cfgSync.TxtPhone        = $txtPhone
    $cfgSync.TxtAddress      = $txtAddress

    # ---- SMTP / Email (optional) ----
    $rowMailServer, $txtMailServer = & $makeCfgRow 'SMTP Server:' 'e.g. smtp.office365.com'
    $rowMailPort,   $txtMailPort   = & $makeCfgRow 'SMTP Port:' '25 or 587' '25'
    $rowMailFrom,   $txtMailFrom   = & $makeCfgRow 'From Address:'
    $rowMailTo,     $txtMailTo     = & $makeCfgRow 'To Address(es):' 'Comma-separated'
    $cfgSync.TxtMailServer = $txtMailServer
    $cfgSync.TxtMailPort   = $txtMailPort
    $cfgSync.TxtMailFrom   = $txtMailFrom
    $cfgSync.TxtMailTo     = $txtMailTo

    $chkMailSSL   = [CheckBox]::new(); $chkMailSSL.Content   = 'Use SSL/TLS'
    $chkMailCreds = [CheckBox]::new(); $chkMailCreds.Content = 'Requires Credentials'
    $cfgSync.ChkMailSSL   = $chkMailSSL
    $cfgSync.ChkMailCreds = $chkMailCreds
    $rowMailChk = [StackPanel]::new()
    $rowMailChk.Orientation = 'Horizontal'; $rowMailChk.Spacing = 16
    $rowMailChk.Margin = [Thickness]::new(138, 0, 0, 0)
    $rowMailChk.Children.Add($chkMailSSL)   | Out-Null
    $rowMailChk.Children.Add($chkMailCreds) | Out-Null

    # ---- Save path ----
    $lblSavePath = [TextBlock]::new(); $lblSavePath.Text = 'Save Config To:'
    $lblSavePath.Width = 130; $lblSavePath.VerticalAlignment = 'Center'
    $defaultConfigDir = Join-Path $HOME 'AsBuiltReport'
    $defaultConfigFile = Join-Path $defaultConfigDir 'AsBuiltReport.json'
    $txtSavePath = [TextBox]::new(); $txtSavePath.Width = 230; $txtSavePath.Text = $defaultConfigFile
    $cfgSync.TxtSavePath = $txtSavePath

    $btnBrowseSave = [Button]::new(); $btnBrowseSave.Content = 'Browse'; $btnBrowseSave.Width = 70
    $btnBrowseSave.AddClick({
        if ($IsWindows) {
            try {
                Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
                $sfd = [System.Windows.Forms.SaveFileDialog]::new()
                $sfd.Title = 'Save AsBuiltReport Config As'
                $sfd.Filter = 'JSON files (*.json)|*.json|All files (*.*)|*.*'
                $sfd.FileName = 'AsBuiltReport.json'
                if ($sfd.ShowDialog() -eq 'OK') {
                    $cfgSync.TxtSavePath.Text = $sfd.FileName
                }
            } catch {
                Add-LogLine "File browser unavailable. Please type the save path directly."
            }
        }
    })

    $rowSavePath = [StackPanel]::new()
    $rowSavePath.Orientation = 'Horizontal'; $rowSavePath.Spacing = 8
    $rowSavePath.Children.Add($lblSavePath)  | Out-Null
    $rowSavePath.Children.Add($txtSavePath)  | Out-Null
    $rowSavePath.Children.Add($btnBrowseSave) | Out-Null

    # ---- Status label (inside sub-window) ----
    $lblCfgStatus = [TextBlock]::new(); $lblCfgStatus.Text = ''
    $lblCfgStatus.Margin = [Thickness]::new(0, 4, 0, 0)
    $cfgSync.LblCfgStatus = $lblCfgStatus

    # ---- Save button ----
    $btnSaveCfg = [Button]::new()
    $btnSaveCfg.Content = 'Save Config'
    $btnSaveCfg.HorizontalAlignment = 'Stretch'
    $btnSaveCfg.HorizontalContentAlignment = 'Center'
    $btnSaveCfg.Height = 36
    $btnSaveCfg.Classes.Add('accent')

    $btnSaveCfg.AddClick({
        $savePath = $cfgSync.TxtSavePath.Text.Trim()
        if (-not $savePath) {
            $cfgSync.LblCfgStatus.Text = '[WARNING] Please specify a save path.'
            return
        }

        # Build the config object matching New-AsBuiltConfig's schema
        $toField = $cfgSync.TxtMailTo.Text.Trim()
        $toArray  = if ($toField) {
            $toField -split '\s*,\s*' | Where-Object { $_ -ne '' }
        } else { @() }

        $portVal = 25
        [void][int]::TryParse($cfgSync.TxtMailPort.Text.Trim(), [ref]$portVal)

        $cfgObj = [ordered]@{
            Report  = [ordered]@{
                Author = $cfgSync.TxtAuthor.Text.Trim()
            }
            Company = [ordered]@{
                FullName  = $cfgSync.TxtCompanyFull.Text.Trim()
                ShortName = $cfgSync.TxtCompanyShort.Text.Trim()
                Contact   = $cfgSync.TxtContact.Text.Trim()
                Email     = $cfgSync.TxtCompanyEmail.Text.Trim()
                Phone     = $cfgSync.TxtPhone.Text.Trim()
                Address   = $cfgSync.TxtAddress.Text.Trim()
            }
            Email   = [ordered]@{
                Server      = $cfgSync.TxtMailServer.Text.Trim()
                Port        = $portVal
                UseSSL      = [bool]$cfgSync.ChkMailSSL.IsChecked
                Credentials = [bool]$cfgSync.ChkMailCreds.IsChecked
                From        = $cfgSync.TxtMailFrom.Text.Trim()
                To          = $toArray
                Body        = ''
            }
        }

        try {
            $saveDir = Split-Path $savePath -Parent
            if ($saveDir -and -not (Test-Path $saveDir)) {
                New-Item -Path $saveDir -ItemType Directory -Force | Out-Null
            }
            $cfgObj | ConvertTo-Json -Depth 10 | Set-Content -Path $savePath -Encoding UTF8
            # Propagate path back to the main window's AsBuiltConfig field
            $syncHash.TxtAbrConfig.Text = $savePath
            $cfgWin.Close()
        } catch {
            $cfgSync.LblCfgStatus.Text = "ERROR: $_"
        }
    })

    # ---- Sub-window layout ----
    $cfgPanel = [StackPanel]::new()
    $cfgPanel.Margin = [Thickness]::new(20)
    $cfgPanel.Spacing = 6

    # Section: Report
    $cfgPanel.Children.Add((Get-SectionHeader 'Report Information')) | Out-Null
    $cfgPanel.Children.Add($rowAuthor)        | Out-Null

    # Section: Company
    $cfgPanel.Children.Add((Get-SectionHeader 'Company Information')) | Out-Null
    $cfgPanel.Children.Add($rowCompanyFull)   | Out-Null
    $cfgPanel.Children.Add($rowCompanyShort)  | Out-Null
    $cfgPanel.Children.Add($rowContact)       | Out-Null
    $cfgPanel.Children.Add($rowCompanyEmail)  | Out-Null
    $cfgPanel.Children.Add($rowPhone)         | Out-Null
    $cfgPanel.Children.Add($rowAddress)       | Out-Null

    # Section: Email/SMTP (optional)
    $cfgPanel.Children.Add((Get-SectionHeader 'Email / SMTP Settings (Optional)')) | Out-Null
    $cfgPanel.Children.Add($rowMailServer)    | Out-Null
    $cfgPanel.Children.Add($rowMailPort)      | Out-Null
    $cfgPanel.Children.Add($rowMailFrom)      | Out-Null
    $cfgPanel.Children.Add($rowMailTo)        | Out-Null
    $cfgPanel.Children.Add($rowMailChk)       | Out-Null

    # Section: Save
    $cfgPanel.Children.Add((Get-SectionHeader 'Save Location')) | Out-Null
    $cfgPanel.Children.Add($rowSavePath)      | Out-Null
    $cfgPanel.Children.Add($btnSaveCfg)       | Out-Null
    $cfgPanel.Children.Add($lblCfgStatus)     | Out-Null

    $cfgScroll = [ScrollViewer]::new()
    $cfgScroll.Content = $cfgPanel
    $cfgWin.Content = $cfgScroll
    $cfgWin.Show()
})

$rowAbrConfig = [StackPanel]::new()
$rowAbrConfig.Orientation = 'Horizontal'; $rowAbrConfig.Spacing = 8
$rowAbrConfig.Children.Add($lblAbrConfig)     | Out-Null
$rowAbrConfig.Children.Add($txtAbrConfig)     | Out-Null
$rowAbrConfig.Children.Add($btnBrowseAbrConfig) | Out-Null
$rowAbrConfig.Children.Add($btnGenAbrConfig)  | Out-Null

$panelConfig = [StackPanel]::new(); $panelConfig.Spacing = 6
$panelConfig.Children.Add((Get-SectionHeader 'Report Configuration'))
$panelConfig.Children.Add($rowTarget)
$panelConfig.Children.Add($rowFolder)
$panelConfig.Children.Add($rowName)
$panelConfig.Children.Add($rowLang)
$panelConfig.Children.Add($rowAbrConfig)

# ===========================================================================
# -- OUTPUT FORMATS ----------------------------------------------------------
# ===========================================================================
$chkHtml = [CheckBox]::new(); $chkHtml.Content = 'HTML'; $chkHtml.IsChecked = $true
$chkWord = [CheckBox]::new(); $chkWord.Content = 'Word'; $chkWord.IsChecked = $false
$chkText = [CheckBox]::new(); $chkText.Content = 'Text'; $chkText.IsChecked = $false
$syncHash.ChkHtml = $chkHtml
$syncHash.ChkWord = $chkWord
$syncHash.ChkText = $chkText

$rowFormats = [StackPanel]::new()
$rowFormats.Orientation = 'Horizontal'; $rowFormats.Spacing = 18
$rowFormats.Children.Add($chkHtml)
$rowFormats.Children.Add($chkWord)
$rowFormats.Children.Add($chkText)

$panelFormats = [StackPanel]::new(); $panelFormats.Spacing = 6
$panelFormats.Children.Add((Get-SectionHeader 'Output Formats'))
$panelFormats.Children.Add($rowFormats)

# ===========================================================================
# -- OPTIONS -----------------------------------------------------------------
# ===========================================================================
$chkTimestamp = [CheckBox]::new(); $chkTimestamp.Content = 'Append Timestamp'; $chkTimestamp.IsChecked = $true
$chkHealth = [CheckBox]::new(); $chkHealth.Content = 'Enable HealthCheck'; $chkHealth.IsChecked = $false
$chkDiagrams = [CheckBox]::new(); $chkDiagrams.Content = 'Enable Diagrams'; $chkDiagrams.IsChecked = $true
$chkExportDiag = [CheckBox]::new(); $chkExportDiag.Content = 'Export Diagrams'; $chkExportDiag.IsChecked = $false
$syncHash.ChkTimestamp = $chkTimestamp
$syncHash.ChkHealth = $chkHealth
$syncHash.ChkDiagrams = $chkDiagrams
$syncHash.ChkExportDiag = $chkExportDiag

$rowOpt1 = [StackPanel]::new()
$rowOpt1.Orientation = 'Horizontal'; $rowOpt1.Spacing = 18
$rowOpt1.Children.Add($chkTimestamp)
$rowOpt1.Children.Add($chkHealth)

$rowOpt2 = [StackPanel]::new()
$rowOpt2.Orientation = 'Horizontal'; $rowOpt2.Spacing = 18
$rowOpt2.Children.Add($chkDiagrams)
$rowOpt2.Children.Add($chkExportDiag)

# Diagram Theme
$lblTheme = [TextBlock]::new(); $lblTheme.Text = 'Diagram Theme:'; $lblTheme.VerticalAlignment = 'Center'
$cbTheme = [ComboBox]::new(); $cbTheme.Width = 120
foreach ($t in @('White', 'Black', 'Neon')) {
    $item = [ComboBoxItem]::new(); $item.Content = $t
    $cbTheme.Items.Add($item) | Out-Null
}
$cbTheme.SelectedIndex = 0
$syncHash.CbTheme = $cbTheme

$rowTheme = [StackPanel]::new()
$rowTheme.Orientation = 'Horizontal'; $rowTheme.Spacing = 8
$rowTheme.Children.Add($lblTheme)
$rowTheme.Children.Add($cbTheme)

$panelOptions = [StackPanel]::new(); $panelOptions.Spacing = 6
$panelOptions.Children.Add((Get-SectionHeader 'Options'))
$panelOptions.Children.Add($rowOpt1)
$panelOptions.Children.Add($rowOpt2)
$panelOptions.Children.Add($rowTheme)

# ===========================================================================
# -- INFO LEVEL --------------------------------------------------------------
# ===========================================================================
function Get-InfoLevelRow {
    param ([string]$Label, [int]$Default = 1)
    $lbl = [TextBlock]::new(); $lbl.Text = "${Label}:"; $lbl.Width = 100; $lbl.VerticalAlignment = 'Center'
    $cb = [ComboBox]::new(); $cb.Width = 70
    foreach ($n in 0..2) {
        $item = [ComboBoxItem]::new(); $item.Content = $n.ToString()
        $cb.Items.Add($item) | Out-Null
    }
    $cb.SelectedIndex = $Default
    $row = [StackPanel]::new(); $row.Orientation = 'Horizontal'; $row.Spacing = 6
    $row.Children.Add($lbl); $row.Children.Add($cb)
    return $row, $cb
}

$rowDate, $cbDate = Get-InfoLevelRow 'Date' 1
$rowTZ, $cbTZ = Get-InfoLevelRow 'TimeZone' 2
$rowUptime, $cbUptime = Get-InfoLevelRow 'Uptime' 2
$rowPSHost, $cbPSHost = Get-InfoLevelRow 'PSHost' 2
$rowProcess, $cbProcess = Get-InfoLevelRow 'ProcessInfo' 1
$syncHash.CbDate = $cbDate
$syncHash.CbTZ = $cbTZ
$syncHash.CbUptime = $cbUptime
$syncHash.CbPSHost = $cbPSHost
$syncHash.CbProcess = $cbProcess

$gridInfo = [StackPanel]::new()
$gridInfo.Spacing = 6
$gridInfo.Children.Add($rowDate) | Out-Null
$gridInfo.Children.Add($rowTZ) | Out-Null
$gridInfo.Children.Add($rowUptime) | Out-Null
$gridInfo.Children.Add($rowPSHost) | Out-Null
$gridInfo.Children.Add($rowProcess) | Out-Null

$panelInfo = [StackPanel]::new(); $panelInfo.Spacing = 6
$panelInfo.Children.Add((Get-SectionHeader 'Info Level  (0=Disabled, 1=Summary, 2=Detailed)'))
$panelInfo.Children.Add($gridInfo)

# ===========================================================================
# -- PROGRESS & LOG ----------------------------------------------------------
# ===========================================================================
$progressBar = [ProgressBar]::new()
$progressBar.IsIndeterminate = $true
$progressBar.IsVisible = $false
$progressBar.Height = 6
$syncHash.ProgressBar = $progressBar

$logBox = [TextBox]::new()
$logBox.IsReadOnly = $true
$logBox.AcceptsReturn = $true
$logBox.Height = 120
$logBox.FontFamily = 'Courier New'
$logBox.FontSize = 11
$logBox.Text = ''
$syncHash.LogBox = $logBox

$logScroll = [ScrollViewer]::new()
$logScroll.Height = 120
$logScroll.Content = $logBox
$syncHash.LogScroll = $logScroll

# ===========================================================================
# -- GENERATE BUTTON ---------------------------------------------------------
# ===========================================================================
$btnGenerate = [Button]::new()
$btnGenerate.Content = 'Generate Report'
$btnGenerate.HorizontalAlignment = 'Stretch'
$btnGenerate.HorizontalContentAlignment = 'Center'
$btnGenerate.Height = 40
$btnGenerate.Classes.Add('accent')
$syncHash.BtnGenerate = $btnGenerate

$lblStatus = [TextBlock]::new()
$lblStatus.Text = 'Ready.'
$lblStatus.Margin = [Thickness]::new(0, 4, 0, 0)
$syncHash.LblStatus = $lblStatus

# ---------------------------------------------------------------------------
# Generate button click - runs on RunspacePoolAsyncUI so the UI stays alive
# ---------------------------------------------------------------------------
$generateCallback = [EventCallback]::new()
$generateCallback.RunspaceMode = 'RunspacePoolAsyncUI'
$generateCallback.DisabledControlsWhileProcessing = $btnGenerate
$generateCallback.ArgumentList = $syncHash

$generateCallback.ScriptBlock = {
    param ($syncHash)

    # ---- Collect values from UI ----------------------------------------
    $target = $syncHash.TxtTarget.Text.Trim()
    $outFolder = $syncHash.TxtFolder.Text.Trim()
    $reportName = $syncHash.TxtName.Text.Trim()
    $language = ($syncHash.CbLang.SelectedItem).Content

    $formats = @()
    if ($syncHash.ChkHtml.IsChecked) { $formats += 'Html' }
    if ($syncHash.ChkWord.IsChecked) { $formats += 'Word' }
    if ($syncHash.ChkText.IsChecked) { $formats += 'Text' }

    $useTimestamp = [bool]$syncHash.ChkTimestamp.IsChecked
    $useHealth = [bool]$syncHash.ChkHealth.IsChecked
    $diagTheme = ($syncHash.CbTheme.SelectedItem).Content

    $infoDate = [int]($syncHash.CbDate.SelectedItem).Content
    $infoTZ = [int]($syncHash.CbTZ.SelectedItem).Content
    $infoUptime = [int]($syncHash.CbUptime.SelectedItem).Content
    $infoPSHost = [int]($syncHash.CbPSHost.SelectedItem).Content
    $infoProcess = [int]($syncHash.CbProcess.SelectedItem).Content
    $enableDiag = [bool]$syncHash.ChkDiagrams.IsChecked
    $exportDiag = [bool]$syncHash.ChkExportDiag.IsChecked

    # ---- Validate -------------------------------------------------------
    if (-not $target) {
        $syncHash.LblStatus.Text = '[WARNING] Target cannot be empty.'
        return
    }
    if (-not $outFolder) {
        $syncHash.LblStatus.Text = '[WARNING] Output folder cannot be empty.'
        return
    }
    if ($formats.Count -eq 0) {
        $syncHash.LblStatus.Text = '[WARNING] Select at least one output format.'
        return
    }

    # ---- Show progress --------------------------------------------------
    $syncHash.ProgressBar.IsVisible = $true
    $syncHash.LblStatus.Text = 'Generating report...'
    $syncHash.LogBox.Text = ''

    $ts = (Get-Date).ToString('HH:mm:ss')
    $syncHash.LogBox.Text += "[$ts] Starting report generation for target '$target'...`n"
    $syncHash.LogBox.Text += "[$ts] Output folder : $outFolder`n"
    $syncHash.LogBox.Text += "[$ts] Format(s)     : $($formats -join ', ')`n"
    $syncHash.LogBox.Text += "[$ts] Language      : $language`n"
    $syncHash.LogBox.Text += "[$ts] Diagram theme : $diagTheme`n"

    # ---- Build a temporary JSON config file ----------------------------
    $configObj = [ordered]@{
        Report = [ordered]@{
            Name = $reportName
            Version = '1.0'
            Status = 'Released'
            Language = $language
            ShowCoverPageImage = $true
            ShowTableOfContents = $true
            ShowHeaderFooter = $true
            ShowTableCaptions = $true
        }
        Options = [ordered]@{
            EnableDiagrams = $enableDiag
            EnableDiagramDebug = $false
            EnableDiagramMainLogo = $false
            DiagramTheme = $diagTheme
            DiagramWaterMark = ''
            ExportDiagrams = $exportDiag
            ExportDiagramsFormat = @('png')
            EnableDiagramSignature = $false
            DiagramColumnSize = 4
            SignatureAuthorName = ''
            SignatureCompanyName = ''
        }
        InfoLevel = [ordered]@{
            Date = $infoDate
            TimeZone = $infoTZ
            Uptime = $infoUptime
            PSHost = $infoPSHost
            ProcessInfo = $infoProcess
        }
        HealthCheck = [ordered]@{}
    }

    $tmpConfig = [System.IO.Path]::Combine(
        [System.IO.Path]::GetTempPath(),
        "AsBuiltReport.System.Resources.$(Get-Date -Format 'yyyyMMddHHmmss').json"
    )
    $configObj | ConvertTo-Json -Depth 10 | Set-Content -Path $tmpConfig -Encoding UTF8

    $ts = (Get-Date).ToString('HH:mm:ss')
    $syncHash.LogBox.Text += "[$ts] Temp config    : $tmpConfig`n"

    # ---- Assemble New-AsBuiltReport parameters -------------------------
    $abrParams = @{
        Report               = 'System.Resources'
        Target               = $target
        Format               = $formats
        OutputFolderPath     = $outFolder
        ReportConfigFilePath = $tmpConfig
        ReportLanguage       = $language
        ErrorAction          = 'Stop'
    }
    if ($useTimestamp) { $abrParams['Timestamp']           = $true }
    if ($useHealth)    { $abrParams['EnableHealthCheck']   = $true }

    $abrConfigPath = $syncHash.TxtAbrConfig.Text.Trim()
    if ($abrConfigPath) {
        if (Test-Path $abrConfigPath) {
            $abrParams['AsBuiltConfigFilePath'] = $abrConfigPath
            $ts = (Get-Date).ToString('HH:mm:ss')
            $syncHash.LogBox.Text += "[$ts] AsBuiltReport config : $abrConfigPath`n"
        } else {
            $ts = (Get-Date).ToString('HH:mm:ss')
            $syncHash.LogBox.Text += "[$ts] [WARNING] AsBuiltReport config not found, skipping: $abrConfigPath`n"
        }
    }

    # ---- Run the report -------------------------------------------------
    try {
        $ts = (Get-Date).ToString('HH:mm:ss')
        $syncHash.LogBox.Text += "[$ts] Invoking New-AsBuiltReport...`n"
        $syncHash.LogScroll.ScrollToEnd()

        New-AsBuiltReport @abrParams 4>&1 | ForEach-Object {
            $line = $_.ToString()
            $ts2 = (Get-Date).ToString('HH:mm:ss')
            $syncHash.LogBox.Text += "[$ts2] $line`n"
            $syncHash.LogScroll.ScrollToEnd()
        }

        $ts = (Get-Date).ToString('HH:mm:ss')
        $syncHash.LogBox.Text += "[$ts] Report generation complete.`n"
        $syncHash.LblStatus.Text = "Done! Report saved to: $outFolder"
    } catch {
        $ts = (Get-Date).ToString('HH:mm:ss')
        $syncHash.LogBox.Text += "[$ts] ERROR: $_`n"
        $syncHash.LblStatus.Text = "ERROR: $($_.Exception.Message)"
    } finally {
        # Clean up temp config
        if (Test-Path $tmpConfig) { Remove-Item $tmpConfig -Force -ErrorAction SilentlyContinue }
        $syncHash.ProgressBar.IsVisible = $false
        $syncHash.LogScroll.ScrollToEnd()
    }
}

$btnGenerate.AddClick($generateCallback)

# ===========================================================================
# -- LAYOUT - stack everything into a ScrollViewer ---------------------------
# ===========================================================================
$mainPanel = [StackPanel]::new()
$mainPanel.Margin = [Thickness]::new(20)
$mainPanel.Spacing = 4
$mainPanel.Children.Add($panelConfig)
$mainPanel.Children.Add($panelFormats)
$mainPanel.Children.Add($panelOptions)
$mainPanel.Children.Add($panelInfo)
$mainPanel.Children.Add($progressBar)
$mainPanel.Children.Add($btnGenerate)
$mainPanel.Children.Add($lblStatus)
$mainPanel.Children.Add($logScroll)

$scroll = [ScrollViewer]::new()
$scroll.Content = $mainPanel

$win.Content = $scroll
$win.Show()
$win.WaitForClosed()
