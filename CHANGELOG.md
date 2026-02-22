# :arrows_clockwise: System Resources As Built Report Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - Unreleased

### Added

- Add initial support for diagrams using the Diagrammer module
  - Add Export-AbrDiagram function to handle diagram exports
  - Generate a Process Hierarchy Diagram in Invoke-AsBuiltReport.System.Resources
- Add initial support for charts
    - Generate Memory Usage and CPU Usage charts in Invoke-AsBuiltReport.System.Resources

### Changed

- Increase module dependencies:
    - AsBuiltReport.Core minimum version increased to 1.6.2
    - Diagrammer.Core minimum version increased to 0.2.38
    - AsBuiltReport.Chart minimum version increased to 0.2.0

## [0.1.1] - 2025-10-11

### Added

- Introduce multi-language support.
- Add sections for Date, TimeZone, Uptime, PowerShell Host, and Process.