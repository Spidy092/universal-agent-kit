param(
  [Alias("f")]
  [switch]$Force,
  [switch]$Uninstall,
  [Alias("h")]
  [switch]$Help,
  [Alias("v")]
  [switch]$Version
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$KitVersion = if (Test-Path (Join-Path $ScriptDir "VERSION")) {
  (Get-Content (Join-Path $ScriptDir "VERSION") -Raw).Trim()
} else {
  "unknown"
}

function Show-Help {
  @"
Universal Agent Kit - Windows Global Installer

Usage:
  powershell -ExecutionPolicy Bypass -File .\install-global-agent-kit.ps1 [OPTIONS]

Options:
  -Help, -h       Show this help message
  -Version, -v    Show version
  -Force, -f      Force reinstall even if already installed
  -Uninstall      Remove global installation

After install:
  cd C:\path\to\project
  agent-init
"@
}

function Show-Version {
  Write-Host "Universal Agent Kit v$KitVersion"
}

function Copy-KitFiles {
  param(
    [Parameter(Mandatory = $true)][string]$SourceDir,
    [Parameter(Mandatory = $true)][string]$TargetDir
  )

  $entries = @(
    "AGENTS.md",
    "ANTIGRAVITY.md",
    "CLAUDE.md",
    "GEMINI.md",
    "README.md",
    "USAGE_GUIDE.md",
    "VERSION",
    "Makefile",
    "opencode.jsonc",
    "install-global-agent-kit.sh",
    "install-global-agent-kit.ps1",
    ".agents",
    ".antigravity",
    ".claude",
    ".codex",
    ".gemini",
    ".opencode",
    ".pi",
    "docs",
    "scripts",
    "tests",
    "templates"
  )

  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

  $oldGit = Join-Path $TargetDir ".git"
  if (Test-Path $oldGit) {
    Remove-Item -LiteralPath $oldGit -Recurse -Force -ErrorAction SilentlyContinue
  }

  foreach ($entry in $entries) {
    $source = Join-Path $SourceDir $entry
    if (Test-Path $source) {
      $target = Join-Path $TargetDir $entry
      if (Test-Path $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
      }
      Copy-Item -LiteralPath $source -Destination $TargetDir -Recurse -Force
    }
  }
}

function Install-LinkOrCopy {
  param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Target,
    [Parameter(Mandatory = $true)][ValidateSet("Directory", "File")][string]$Type
  )

  if (Test-Path $Target) {
    return $false
  }

  try {
    if ($Type -eq "Directory") {
      New-Item -ItemType Junction -Path $Target -Target $Source -ErrorAction Stop | Out-Null
    } else {
      New-Item -ItemType SymbolicLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
    }
  } catch {
    if ($Type -eq "Directory") {
      Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force
    } else {
      Copy-Item -LiteralPath $Source -Destination $Target -Force
    }
  }

  return $true
}

function Add-UserPath {
  param([Parameter(Mandatory = $true)][string]$PathToAdd)

  $current = [Environment]::GetEnvironmentVariable("Path", "User")
  $parts = @()
  if ($current) {
    $parts = $current -split ";" | Where-Object { $_ }
  }

  if ($parts -notcontains $PathToAdd) {
    $newPath = if ($current) { "$current;$PathToAdd" } else { $PathToAdd }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    $env:Path = "$env:Path;$PathToAdd"
  }
}

if ($Help) {
  Show-Help
  exit 0
}

if ($Version) {
  Show-Version
  exit 0
}

$target = Join-Path $env:USERPROFILE ".ai-agents"
$binDir = Join-Path $env:LOCALAPPDATA "Programs\UniversalAgentKit"
$initCmd = Join-Path $binDir "agent-init.ps1"
$initCmdWrapper = Join-Path $binDir "agent-init.cmd"
$updateCmd = Join-Path $binDir "agent-kit-update.ps1"
$updateCmdWrapper = Join-Path $binDir "agent-kit-update.cmd"

if ($Uninstall) {
  Write-Host "Uninstalling Universal Agent Kit..."
  Remove-Item -LiteralPath $target -Recurse -Force -ErrorAction SilentlyContinue
  Remove-Item -LiteralPath $initCmd, $initCmdWrapper, $updateCmd, $updateCmdWrapper -Force -ErrorAction SilentlyContinue
  Write-Host "Removed: $target"
  Write-Host "Removed commands from: $binDir"
  Write-Host "Done. You may also remove $binDir from your user PATH."
  exit 0
}

if (-not (Test-Path (Join-Path $ScriptDir "AGENTS.md"))) {
  Write-Error "Run this script from inside the extracted universal-agent-kit folder."
}

if ((Test-Path $target) -and -not $Force) {
  Write-Host "Universal Agent Kit already installed at $target"
  Write-Host "Use -Force to reinstall/upgrade"
  exit 0
}

New-Item -ItemType Directory -Force -Path $target, $binDir | Out-Null
Copy-KitFiles -SourceDir $ScriptDir -TargetDir $target

@'
param(
  [Alias("r")]
  [switch]$Rollback,
  [switch]$DryRun,
  [switch]$Force,
  [Alias("h")]
  [switch]$Help,
  [Alias("v")]
  [switch]$Version
)

$ErrorActionPreference = "Stop"

$kit = if ($env:AI_AGENTS_HOME) { $env:AI_AGENTS_HOME } else { Join-Path $env:USERPROFILE ".ai-agents" }
$versionFile = Join-Path $kit "VERSION"
$kitVersion = if (Test-Path $versionFile) { (Get-Content $versionFile -Raw).Trim() } else { "unknown" }

function Show-Help {
  @"
Universal Agent Kit - Project Initializer

Usage:
  agent-init [OPTIONS]

Options:
  -Help, -h       Show this help message
  -Version, -v    Show version
  -Rollback, -r   Undo agent-init
  -DryRun         Show what would be done without doing it
  -Force          Overwrite existing files
"@
}

function Install-LinkOrCopy {
  param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Target,
    [Parameter(Mandatory = $true)][ValidateSet("Directory", "File")][string]$Type
  )

  if (Test-Path $Target) {
    return $false
  }

  try {
    if ($Type -eq "Directory") {
      New-Item -ItemType Junction -Path $Target -Target $Source -ErrorAction Stop | Out-Null
    } else {
      New-Item -ItemType SymbolicLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
    }
  } catch {
    if ($Type -eq "Directory") {
      Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force
    } else {
      Copy-Item -LiteralPath $Source -Destination $Target -Force
    }
  }

  return $true
}

if ($Help) {
  Show-Help
  exit 0
}

if ($Version) {
  Write-Host "Universal Agent Kit v$kitVersion"
  exit 0
}

if (-not (Test-Path (Join-Path $kit "AGENTS.md"))) {
  Write-Error "Global agent kit not found at $kit. Install it first with install-global-agent-kit.ps1."
}

$projectDir = (Get-Location).Path

if ($Rollback) {
  Write-Host "Rolling back agent-init in: $projectDir"
  foreach ($entry in @(".agents", ".claude", ".codex", ".opencode", ".pi")) {
    $path = Join-Path $projectDir $entry
    if ((Test-Path $path) -and ((Get-Item $path).Attributes -band [IO.FileAttributes]::ReparsePoint)) {
      Remove-Item -LiteralPath $path -Force
      Write-Host "Removed: $entry"
    }
  }
  Write-Host ""
  Write-Host "Rollback complete."
  exit 0
}

if ($DryRun) {
  Write-Host "DRY RUN - Would create/link in: $projectDir"
  if (-not (Test-Path (Join-Path $projectDir "AGENTS.md"))) { Write-Host "  + AGENTS.md" }
  if (-not (Test-Path (Join-Path $projectDir ".agents"))) { Write-Host "  + .agents -> global skills" }
  if (-not (Test-Path (Join-Path $projectDir "CLAUDE.md"))) { Write-Host "  + CLAUDE.md" }
  if (-not (Test-Path (Join-Path $projectDir ".claude"))) { Write-Host "  + .claude/skills" }
  foreach ($d in @(".codex", ".opencode", ".pi")) {
    if (-not (Test-Path (Join-Path $projectDir $d))) { Write-Host "  + $d" }
  }
  exit 0
}

$projectAgents = Join-Path $projectDir "AGENTS.md"
if ((-not (Test-Path $projectAgents)) -or $Force) {
  @"
# Project Agent Rules

This project uses my global AI agent kit.

Use this file as the command router and source of truth.
Global workflows live here:
``%USERPROFILE%\.ai-agents\.agents``

## Command Router

Inside any coding agent, use short workflow commands:

````txt
/bug
/review
/fix add login validation
/ui fix mobile navbar
/security
/deploy
/docs check latest OpenWA docs
/refactor
/test
/mode strict
/mode frontend
/mode security
/mode production
/use debugging security
/use frontend-ui testing
/find-skill whatsapp automation
````

If an agent does not natively recognize slash commands, still treat these as workflow commands using this router.

## Router Files

- `.agents/commands` defines command behavior.
- `.agents/modes` defines session-wide behavior.
- `.agents/skills` defines reusable workflows.
- If no local skill matches, use `find-skills` to search `skills.sh` or the Skills CLI.

## Project Context

Fill this once per project:

- Main stack:
- Package manager:
- Dev command:
- Test command:
- Build command:
- Deploy target:
- Important folders:
- Do not edit:

## Routing Rules

- `/bug` or `/debug` -> debugging workflow.
- `/review` -> code-review workflow.
- `/fix <task>` -> structured fix workflow with relevant skills auto-added.
- `/ui` or `/frontend` -> frontend-ui workflow.
- `/security` -> security-audit workflow.
- `/deploy` or `/devops` -> devops-deploy workflow.
- `/docs` or `/research` -> docs-research workflow.
- `/refactor` -> refactor workflow.
- `/test` -> testing workflow.
- `/use <skill1> <skill2>` -> combine named skills.
- `/mode <mode>` -> activate a session-wide mode.
- `/mode reset` -> clear active modes.
- `/find-skill <query>` or `/skills find <query>` -> search for an external skill when no local skill matches.
- `/help` -> show available commands and modes.

## Rules

- Read existing code before changing.
- Make the smallest safe change.
- Do not rewrite unrelated code.
- Do not delete files, reset DB, or force push without asking.
- Do not expose `.env`, tokens, secrets, private keys, or credentials.
- Give exact files changed.
- Give exact commands to test.
- Mention edge cases.

## Output Format

For serious work:

````md
## Summary
## What I found
## Fix / Changes
## Files changed
## Commands to run
## Verification
## Risks / Edge cases
````
"@ | Set-Content -Path $projectAgents -Encoding UTF8
  Write-Host "Created AGENTS.md"
} else {
  Write-Host "AGENTS.md already exists, not overwritten. (use -Force to overwrite)"
}

if (Install-LinkOrCopy -Source (Join-Path $kit ".agents") -Target (Join-Path $projectDir ".agents") -Type Directory) {
  Write-Host "Linked .agents -> global skills"
} else {
  Write-Host ".agents already exists, not changed."
}

$projectClaude = Join-Path $projectDir "CLAUDE.md"
if ((-not (Test-Path $projectClaude)) -or $Force) {
  Copy-Item -LiteralPath $projectAgents -Destination $projectClaude -Force
  Write-Host "Created CLAUDE.md"
} else {
  Write-Host "CLAUDE.md already exists, not overwritten."
}

$claudeDir = Join-Path $projectDir ".claude"
if (-not (Test-Path $claudeDir)) {
  New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
  Install-LinkOrCopy -Source (Join-Path $projectDir ".agents\skills") -Target (Join-Path $claudeDir "skills") -Type Directory | Out-Null
  Write-Host "Created .claude/skills"
}

foreach ($d in @(".codex", ".opencode", ".pi")) {
  $source = Join-Path $kit $d
  $target = Join-Path $projectDir $d
  if ((Test-Path $source) -and (Install-LinkOrCopy -Source $source -Target $target -Type Directory)) {
    Write-Host "Linked $d"
  }
}

Write-Host ""
Write-Host "Done. (v$kitVersion)"
Write-Host "Now open any agent in this project and use:"
Write-Host "  /bug"
Write-Host "  /ui fix mobile navbar"
Write-Host "  /mode frontend"
Write-Host "  /use debugging security"
'@ | Set-Content -Path $initCmd -Encoding UTF8

@"
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0agent-init.ps1" %*
"@ | Set-Content -Path $initCmdWrapper -Encoding ASCII

@'
param(
  [string]$Source,
  [Alias("h")]
  [switch]$Help
)

$ErrorActionPreference = "Stop"

function Copy-KitFiles {
  param(
    [Parameter(Mandatory = $true)][string]$SourceDir,
    [Parameter(Mandatory = $true)][string]$TargetDir
  )

  $entries = @(
    "AGENTS.md", "ANTIGRAVITY.md", "CLAUDE.md", "GEMINI.md",
    "README.md", "USAGE_GUIDE.md", "VERSION", "Makefile",
    "opencode.jsonc", "install-global-agent-kit.sh",
    "install-global-agent-kit.ps1", ".agents", ".antigravity",
    ".claude", ".codex", ".gemini", ".opencode", ".pi",
    "docs", "scripts", "tests", "templates"
  )

  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

  $oldGit = Join-Path $TargetDir ".git"
  if (Test-Path $oldGit) {
    Remove-Item -LiteralPath $oldGit -Recurse -Force -ErrorAction SilentlyContinue
  }

  foreach ($entry in $entries) {
    $source = Join-Path $SourceDir $entry
    if (Test-Path $source) {
      $target = Join-Path $TargetDir $entry
      if (Test-Path $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
      }
      Copy-Item -LiteralPath $source -Destination $TargetDir -Recurse -Force
    }
  }
}

if ($Help -or -not $Source) {
  Write-Host "Universal Agent Kit - Updater"
  Write-Host ""
  Write-Host "Usage:"
  Write-Host "  agent-kit-update C:\path\to\new\universal-agent-kit"
  exit 0
}

if (-not (Test-Path (Join-Path $Source "AGENTS.md"))) {
  Write-Error "$Source does not look like universal-agent-kit folder."
}

$kit = if ($env:AI_AGENTS_HOME) { $env:AI_AGENTS_HOME } else { Join-Path $env:USERPROFILE ".ai-agents" }
Copy-KitFiles -SourceDir $Source -TargetDir $kit
Write-Host "Updated global agent kit at $kit"
'@ | Set-Content -Path $updateCmd -Encoding UTF8

@"
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0agent-kit-update.ps1" %*
"@ | Set-Content -Path $updateCmdWrapper -Encoding ASCII

Add-UserPath -PathToAdd $binDir

Write-Host ""
Write-Host "Installed Universal Agent Kit v$KitVersion to: $target"
Write-Host "Installed commands in: $binDir"
Write-Host ""
Write-Host "Restart terminal, then run in any project:"
Write-Host "  agent-init"
