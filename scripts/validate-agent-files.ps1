$ErrorActionPreference = "Stop"

# Universal Agent Kit - File Validator
# Validates all agent configuration files are present and well-formed.

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kitDir = Split-Path -Parent $scriptDir
$errors = 0
$warnings = 0

function Write-Ok {
  param([string]$Message)
  Write-Host "OK: $Message"
}

function Write-Warn {
  param([string]$Message)
  $script:warnings += 1
  Write-Host "WARN: $Message"
}

function Write-ErrorLine {
  param([string]$Message)
  $script:errors += 1
  Write-Host "ERROR: $Message"
}

function Test-FileContains {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Pattern
  )

  if (-not (Test-Path $Path)) {
    return $false
  }

  return [bool](Select-String -Path $Path -Pattern $Pattern -Quiet)
}

Write-Host "Validating Universal Agent Kit..."
Write-Host ""

$requiredFiles = @(
  "AGENTS.md",
  "VERSION",
  "README.md",
  "install-global-agent-kit.sh",
  "install-global-agent-kit.ps1",
  "scripts/install-global.ps1",
  "scripts/sync-agent-context.ps1",
  "scripts/validate-agent-files.ps1",
  ".codex/config.toml",
  ".pi/APPEND_SYSTEM.md",
  ".gemini/settings.json"
)

foreach ($file in $requiredFiles) {
  $path = Join-Path $kitDir $file
  if (Test-Path $path -PathType Leaf) {
    Write-Ok $file
  } else {
    Write-ErrorLine "Missing required file: $file"
  }
}

Write-Host ""
Write-Host "Checking skills..."
$skillsDir = Join-Path $kitDir ".agents/skills"
if (Test-Path $skillsDir -PathType Container) {
  Get-ChildItem -Path $skillsDir -Directory | Sort-Object Name | ForEach-Object {
    $skillFile = Join-Path $_.FullName "SKILL.md"
    if (Test-Path $skillFile -PathType Leaf) {
      $head = (Get-Content $skillFile -TotalCount 5) -join "`n"
      if ($head -match "name:") {
        Write-Ok "Skill: $($_.Name)"
      } else {
        Write-Warn "Skill '$($_.Name)' missing 'name' in frontmatter"
      }
    } else {
      Write-ErrorLine "Skill '$($_.Name)' missing SKILL.md"
    }
  }
} else {
  Write-ErrorLine "Skills directory not found"
}

Write-Host ""
Write-Host "Checking commands..."
$commandsDir = Join-Path $kitDir ".agents/commands"
$requiredCommands = @("bug", "review", "fix", "ui", "security", "deploy", "docs", "refactor", "test", "use", "mode", "help", "find-skill")
if (Test-Path $commandsDir -PathType Container) {
  foreach ($command in $requiredCommands) {
    if (Test-Path (Join-Path $commandsDir "$command.md") -PathType Leaf) {
      Write-Ok "Command: /$command"
    } else {
      Write-ErrorLine "Missing command file: .agents/commands/$command.md"
    }
  }
} else {
  Write-ErrorLine "Commands directory not found"
}

Write-Host ""
Write-Host "Checking modes..."
$modesDir = Join-Path $kitDir ".agents/modes"
$requiredModes = @("strict", "frontend", "security", "production", "fast")
if (Test-Path $modesDir -PathType Container) {
  foreach ($mode in $requiredModes) {
    if (Test-Path (Join-Path $modesDir "$mode.md") -PathType Leaf) {
      Write-Ok "Mode: $mode"
    } else {
      Write-ErrorLine "Missing mode file: .agents/modes/$mode.md"
    }
  }
} else {
  Write-ErrorLine "Modes directory not found"
}

Write-Host ""
Write-Host "Checking adapters..."
$adapters = @(
  ".claude/agents/debugger.md",
  ".claude/agents/reviewer.md",
  ".codex/agents/debugger.toml",
  ".codex/agents/reviewer.toml",
  ".opencode/agents/debug.md",
  ".opencode/agents/review.md",
  ".antigravity/instructions.md"
)

foreach ($adapter in $adapters) {
  if (Test-Path (Join-Path $kitDir $adapter) -PathType Leaf) {
    Write-Ok "Adapter: $adapter"
  } else {
    Write-Warn "Missing adapter: $adapter"
  }
}

Write-Host ""
$versionFile = Join-Path $kitDir "VERSION"
if (Test-Path $versionFile -PathType Leaf) {
  $version = (Get-Content $versionFile -Raw).Trim()
  if ($version -match '^[0-9]+\.[0-9]+\.[0-9]+$') {
    Write-Ok "VERSION format: $version"
  } else {
    Write-Warn "VERSION not in semver format: $version"
  }
}

Write-Host ""
Write-Host "================================"
if ($errors -gt 0) {
  Write-Host "Validation failed: $errors errors, $warnings warnings"
  exit 1
}

if ($warnings -gt 0) {
  Write-Host "Validation passed with $warnings warnings"
  exit 0
}

Write-Host "All validations passed!"
exit 0
