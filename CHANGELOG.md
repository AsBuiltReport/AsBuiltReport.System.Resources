# :arrows_clockwise: System Resources As Built Report Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2026-03-??

### Changed

- Migrate Diagrammer.Core to AsBuiltReport.Diagram for better integration and maintenance
    - Update module dependencies to reflect the change
    - Refactor code to use AsBuiltReport.Diagram instead of Diagrammer.Core
- Bump AsBuiltReport.Chart to version 0.3.0 to include latest charting features and improvements
- Bump AsBuiltReport.Diagram to version 1.0.5 to include latest diagramming features and improvements
- Reorganize module structure - moved module files to AsBuiltReport.System.Resources/ subdirectory
- Update zentered/bluesky-post-action to v0.4.0 for improved stability and performance

## [0.1.2] - 2026-02-22

### Added

- Add initial support for diagrams using the Diagrammer module
  - Add Export-AbrDiagram function to handle diagram exports
  - Generate a Process Hierarchy Diagram
- Add initial support for charts
    - Generate Memory Usage and CPU Usage charts

### Changed

- Increase module dependencies:
    - AsBuiltReport.Core minimum version increased to 1.6.2
    - Diagrammer.Core minimum version increased to 0.2.38
    - AsBuiltReport.Chart minimum version increased to 0.2.0

### Fixed

- Fix process name display in Process section and diagram by removing extra information from the process name

## [0.1.1] - 2025-10-11

### Added

- Introduce multi-language support.
- Add sections for Date, TimeZone, Uptime, PowerShell Host, and Process.
