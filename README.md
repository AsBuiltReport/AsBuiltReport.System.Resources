<!-- ********** DO NOT EDIT THESE LINKS ********** -->
<p align="center">
    <a href="https://www.asbuiltreport.com/" alt="AsBuiltReport"></a>
            <img src='https://github.com/AsBuiltReport.png' width="8%" height="8%" /></a>
</p>
<p align="center">
    <a href="https://www.powershellgallery.com/packages/AsBuiltReport.System.Resources/" alt="PowerShell Gallery Version">
        <img src="https://img.shields.io/powershellgallery/v/AsBuiltReport.System.Resources.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/AsBuiltReport.System.Resources/" alt="PS Gallery Downloads">
        <img src="https://img.shields.io/powershellgallery/dt/AsBuiltReport.System.Resources.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/AsBuiltReport.System.Resources/" alt="PS Platform">
        <img src="https://img.shields.io/powershellgallery/p/AsBuiltReport.System.Resources.svg" /></a>
</p>
<p align="center">
    <a href="https://github.com/AsBuiltReport/AsBuiltReport.System.Resources/graphs/commit-activity" alt="GitHub Last Commit">
        <img src="https://img.shields.io/github/last-commit/AsBuiltReport/AsBuiltReport.System.Resources/master.svg" /></a>
    <a href="https://raw.githubusercontent.com/AsBuiltReport/AsBuiltReport.System.Resources/master/LICENSE" alt="GitHub License">
        <img src="https://img.shields.io/github/license/AsBuiltReport/AsBuiltReport.System.Resources.svg" /></a>
    <a href="https://github.com/AsBuiltReport/AsBuiltReport.System.Resources/graphs/contributors" alt="GitHub Contributors">
        <img src="https://img.shields.io/github/contributors/AsBuiltReport/AsBuiltReport.System.Resources.svg"/></a>
</p>
<p align="center">
    <a href="https://twitter.com/AsBuiltReport" alt="Twitter">
            <img src="https://img.shields.io/twitter/follow/AsBuiltReport.svg?style=social"/></a>
</p>

<p align="center">
    <a href='https://ko-fi.com/F1F8DEV80' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>
<!-- ********** DO NOT EDIT THESE LINKS ********** -->

# System Resources As Built Report

> [!IMPORTANT]
> The intention of this report is to ilustrate the capabilities of the AsBuiltReport project. This report is not intended to be used for production environments and should only be used for testing and demonstration purposes.

System Resources As Built Report is a PowerShell module which works in conjunction with [AsBuiltReport.Core](https://github.com/AsBuiltReport/AsBuiltReport.Core).

[AsBuiltReport](https://github.com/AsBuiltReport/AsBuiltReport) is an open-sourced community project which utilises PowerShell to produce as-built documentation in multiple document formats for multiple vendors and technologies.

Please refer to the AsBuiltReport [website](https://www.asbuiltreport.com) for more detailed information about this project.

## :books: Sample Reports

### Sample Report
Sample System Resources As Built report HTML file: [Sample System Resources As-Built Report.html](https://htmlpreview.github.io/?https://raw.githubusercontent.com/AsBuiltReport/AsBuiltReport.System.Resources/dev/Samples/Sample%20System%20Resources%20As-Built%20Report.html)

# :beginner: Getting Started
Below are the instructions on how to install, configure and generate a System Resources As Built report.

## :floppy_disk: Supported Versions
<!-- ********** Update supported Resources versions ********** -->
The System Resources As Built Report supports the following Resources versions;

### PowerShell
This report is compatible with the following PowerShell versions;

<!-- ********** Update supported PowerShell versions ********** -->
| Windows PowerShell 5.1 |    PowerShell 7    |
| :--------------------: | :----------------: |
|   :white_check_mark:   | :white_check_mark: |

## 🗺️ Language Support
### Supported Languages
- English (US) (Default)
- English (GB)
- Arabic (SA)
- Czech (CZ)
- Danish (DK)
- Dutch (NL)
- Finnish (FI)
- French (FR)
- German (DE)
- Greek (GR)
- Hebrew (IL)
- Hindi (HI)
- Hungarian (HU)
- Italian (IT)
- Japanese (JP)
- Korean (KR)
- Norwegian (NO)
- Polish (PL)
- Portuguese (PT)
- Russian (RU)
- Simplified Chinese
- Spanish (ES)
- Swedish (SE)
- Thai (TH)
- Traditional Chinese
- Turkish (TR)
- Vietnamese (VN)

## :wrench: System Requirements
<!-- ********** Update system requirements ********** -->
PowerShell 5.1 or PowerShell 7, and the following PowerShell modules are required for generating a System Resources As Built Report.

- [AsBuiltReport.System.Resources Module](https://www.powershellgallery.com/packages/AsBuiltReport.System.Resources/)

> [!IMPORTANT]
> This report requires AsBuiltReport.Core version 1.5.0 or later to be installed. [Multilingual-support](https://www.asbuiltreport.com/blog/2025/09/05/Multilingual-support/)

### :closed_lock_with_key: Required Privileges

Local user privileges are required to run this report.

## :package: Module Installation

### PowerShell
<!-- ********** Add installation for any additional PowerShell module(s) ********** -->
```powershell
# Install
install-module AsBuiltReport.System.Resources -Force

# Update
update-module AsBuiltReport.System.Resources -Force
```

### GitHub
If you are unable to use the PowerShell Gallery, you can still install the module manually. Ensure you repeat the following steps for the [system requirements](https://github.com/AsBuiltReport/AsBuiltReport.System.Resources#wrench-system-requirements) also.

1. Download the code package / [latest release](https://github.com/AsBuiltReport/AsBuiltReport.System.Resources/releases/latest) zip from GitHub
2. Extract the zip file
3. Copy the folder `AsBuiltReport.System.Resources` to a path that is set in `$env:PSModulePath`.
4. Open a PowerShell terminal window and unblock the downloaded files with
    ```powershell
    $path = (Get-Module -Name AsBuiltReport.System.Resources -ListAvailable).ModuleBase; Unblock-File -Path $path\*.psd1; Unblock-File -Path $path\Src\Public\*.ps1; Unblock-File -Path $path\Src\Private\*.ps1
    ```
5. Close and reopen the PowerShell terminal window.

_Note: You are not limited to installing the module to those example paths, you can add a new entry to the environment variable PSModulePath if you want to use another path._

## :pencil2: Configuration

The System Resources As Built Report utilises a JSON file to allow configuration of report information, options, detail and healthchecks.

> [!IMPORTANT]
> Please remember to generate a new report JSON configuration file after each module update to ensure the report functions correctly.

A System Resources report configuration file can be generated by executing the following command;
```powershell
New-AsBuiltReportConfig -Report System.Resources -FolderPath <User specified folder> -Filename <Optional>
```

Executing this command will copy the default System Resources report JSON configuration to a user specified folder.

All report settings can then be configured via the JSON file.

The following provides information of how to configure each schema within the report's JSON file.

<!-- ********** DO NOT CHANGE THE REPORT SCHEMA SETTINGS ********** -->
### Report
The **Report** schema provides configuration of the System Resources report information.

| Sub-Schema          | Setting      | Default                          | Description                                                  |
| ------------------- | ------------ | -------------------------------- | ------------------------------------------------------------ |
| Name                | User defined | System Resources As Built Report | The name of the As Built Report                              |
| Version             | User defined | 1.0                              | The report version                                           |
| Status              | User defined | Released                         | The report release status                                    |
| Language            | User defined | en-US                            | The language / locale of the report                          |
| ShowCoverPageImage  | true / false | true                             | Toggle to enable/disable the display of the cover page image |
| ShowTableOfContents | true / false | true                             | Toggle to enable/disable table of contents                   |
| ShowHeaderFooter    | true / false | true                             | Toggle to enable/disable document headers & footers          |
| ShowTableCaptions   | true / false | true                             | Toggle to enable/disable table captions/numbering            |

### Options
The **Options** schema allows certain options within the report to be toggled on or off.

| Sub-Schema             | Setting      | Default | Description                                                                   |
| ---------------------- | ------------ | ------- | ----------------------------------------------------------------------------- |
| DiagramColumnSize      | int          | 3       | Set the diagram node table size                                               |
| DiagramTheme           | string       | White   | Set the diagram theme (Black/White/Neon)                                      |
| DiagramWaterMark       | string       | empty   | Set the diagram watermark                                                     |
| DiagramType            | true / false | true    | Toggle to enable/disable the export of individual diagram diagrams            |
| DisableDiagramMainLogo | true / false | false   | Toggle to enable/disable the main logo in diagrams                            |
| EnableDiagrams         | true / false | false   | Toggle to enable/disable infrastructure diagrams                              |
| EnableDiagramsDebug    | true / false | false   | Toggle to enable/disable diagram debug option                                 |
| EnableDiagramSignature | true / false | false   | Toggle to enable/disable diagram signature (bottom right corner)              |
| ExportDiagrams         | true / false | true    | Toggle to enable/disable diagram export option                                |
| ExportDiagramsFormat   | string array | png     | Set the format used to export the infrastructure diagram (dot, png, pdf, svg) |
| SignatureAuthorName    | string       | empty   | Set the signature author name                                                 |
| SignatureCompanyName   | string       | empty   | Set the signature company name                                                |

### InfoLevel
The **InfoLevel** schema allows configuration of each section of the report at a granular level. The following sections can be set.

There are 3 levels (0-2) of detail granularity for each section as follows;

| Setting | InfoLevel         | Description                                                          |
| :-----: | ----------------- | -------------------------------------------------------------------- |
|    0    | Disabled          | Does not collect or display any information                          |
|    1    | Enabled / Summary | Provides summarised information for a collection of objects          |
|    2    | Adv Summary       | Provides condensed, detailed information for a collection of objects |

The table below outlines the default and maximum **InfoLevel** settings for each section.

| Sub-Schema | Default Setting | Maximum Setting |
| ---------- | :-------------: | :-------------: |
| Date       |        1        |        2        |
| TimeZone   |        2        |        2        |
| Uptime     |        2        |        2        |
| PSHost     |        2        |        2        |
| Process    |        1        |        2        |

### Healthcheck
The **Healthcheck** schema is used to toggle health checks on or off.

No health checks are currently available for this report.

## :computer: Examples

The following examples demonstrate how to generate a System Resources As Built Report.

Below are a few examples of running the AsBuiltReport script. Refer to the `README.md` file in the main AsBuiltReport project repository for more examples.

```powershell
# Generate a System Resources As Built Report for 'localhost'. Export report to HTML & DOCX formats. Use default report style. Append timestamp to report filename. Save reports to 'C:\Users\Jon\Documents'
PS C:\> New-AsBuiltReport -Report System.Resources -Target localhost -Username 'User' -Password 'P@ssw0rd' -Format Html,Word -OutputFolderPath 'C:\Users\Jon\Documents' -Timestamp

# Generate a System Resources As Built Report for 'localhost' using specified credentials and report configuration file. Export report to Text, HTML & DOCX formats. Use default report style. Save reports to 'C:\Users\Jon\Documents'. Display verbose messages to the console.
PS C:\> New-AsBuiltReport -Report System.Resources -Target localhost -Username 'User' -Password 'P@ssw0rd' -Format Text,Html,Word -OutputFolderPath 'C:\Users\Jon\Documents' -ReportConfigFilePath 'C:\Users\Jon\AsBuiltReport\AsBuiltReport.System.Resources.json' -Verbose

# Generate a System Resources As Built Report for 'localhost' using stored credentials. Export report to HTML & Text formats. Use default report style. Highlight environment issues within the report. Save reports to 'C:\Users\Jon\Documents'.
PS C:\> $Creds = Get-Credential
PS C:\> New-AsBuiltReport -Report System.Resources -Target localhost -Credential $Creds -Format Html,Text -OutputFolderPath 'C:\Users\Jon\Documents' -EnableHealthCheck

# Generate a System Resources As Built Report for Backup Server localhost using stored credentials. Export report to HTML & DOCX formats. Use default report style. Reports are saved to the user profile folder by default. Attach and send reports via e-mail.
PS C:\> New-AsBuiltReport -Report System.Resources -Target localhost -Username 'User' -Password 'P@ssw0rd' -Format Html,Word -OutputFolderPath 'C:\Users\Jon\Documents' -SendEmail

# Generate a System Resources As Built Report for 'localhost'. Export report to HTML & DOCX formats. Use default report style. Save reports to 'C:\Users\Jon\Documents' and set the report language to Spanish.
PS C:\> New-AsBuiltReport -Report System.Resources -Target localhost -Username 'User' -Password 'P@ssw0rd' -Format Html,Word -OutputFolderPath 'C:\Users\Jon\Documents' -ReportLanguage es-ES
```
