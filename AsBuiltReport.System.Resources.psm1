# Module loader for AsBuiltReport.System.Resources
#
# This script is executed automatically by PowerShell when the module is imported. It uses a
# common AsBuiltReport pattern of separating functions into two directories:
#
#   Src/Public/  - Functions exported to the caller (visible after Import-Module).
#                  Typically a single Invoke-AsBuiltReport.<ModuleName> entry point.
#   Src/Private/ - Internal helper functions used only within the module. They are dot-sourced
#                  into the module scope but are also exported so that AsBuiltReport.Core can
#                  call them from within the report document script block, which runs in the
#                  caller's scope.
#
# Any file that fails to dot-source (e.g. due to a syntax error) will emit an error message
# via Write-Error but will not prevent the remaining files from being loaded.

# Collect all public and private function files.
$Public = @(Get-ChildItem -Path $PSScriptRoot\Src\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Src\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach ($Module in @($Public + $Private)) {
    try {
        . $Module.FullName
    } catch {
        Write-Error -Message "Failed to import function $($Module.FullName): $_"
    }
}

# Export public functions by name so they are available to module consumers.
Export-ModuleMember -Function $Public.BaseName
# Export private functions so that AsBuiltReport.Core can invoke them from within the
# PScribo document script block, which executes in the caller's session scope.
Export-ModuleMember -Function $Private.BaseName