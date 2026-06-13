param(
  [switch]$Force,
  [switch]$Uninstall
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kitDir = Split-Path -Parent $scriptDir
$installer = Join-Path $kitDir "install-global-agent-kit.ps1"

if (-not (Test-Path $installer)) {
  Write-Error "Cannot find $installer"
}

& $installer @PSBoundParameters
