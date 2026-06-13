param(
  [string]$ProjectDir = "."
)

$ErrorActionPreference = "Stop"

# Universal Agent Kit - Sync Agent Context
# Syncs AGENTS.md to all agent adapters and creates/updates Windows-friendly links.

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kitDir = Split-Path -Parent $scriptDir
$projectPath = (Resolve-Path $ProjectDir).Path

function Install-LinkOrCopy {
  param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Target
  )

  if (Test-Path $Target) {
    return $false
  }

  try {
    New-Item -ItemType Junction -Path $Target -Target $Source -ErrorAction Stop | Out-Null
  } catch {
    Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force
  }

  return $true
}

Write-Host "Syncing agent context in: $projectPath"
Write-Host ""

$agentsFile = Join-Path $projectPath "AGENTS.md"
if (-not (Test-Path $agentsFile)) {
  Write-Error "AGENTS.md not found in $projectPath"
}

foreach ($dir in @(
  ".claude",
  ".opencode",
  ".codex\agents",
  ".claude\agents",
  ".opencode\agents",
  ".pi"
)) {
  New-Item -ItemType Directory -Force -Path (Join-Path $projectPath $dir) | Out-Null
}

Copy-Item -LiteralPath $agentsFile -Destination (Join-Path $projectPath "CLAUDE.md") -Force
Write-Host "OK: Synced AGENTS.md -> CLAUDE.md"

$skillsDir = Join-Path $projectPath ".agents\skills"
if (Test-Path $skillsDir) {
  if (Install-LinkOrCopy -Source $skillsDir -Target (Join-Path $projectPath ".claude\skills")) {
    Write-Host "OK: Linked .claude/skills"
  }

  if (Install-LinkOrCopy -Source $skillsDir -Target (Join-Path $projectPath ".opencode\skills")) {
    Write-Host "OK: Linked .opencode/skills"
  }
} else {
  Write-Host "WARN: .agents/skills not found; skipped skill links"
}

$geminiSettings = Join-Path $projectPath ".gemini\settings.json"
$kitGeminiSettings = Join-Path $kitDir ".gemini\settings.json"
if ((-not (Test-Path $geminiSettings)) -and (Test-Path $kitGeminiSettings)) {
  New-Item -ItemType Directory -Force -Path (Join-Path $projectPath ".gemini") | Out-Null
  Copy-Item -LiteralPath $kitGeminiSettings -Destination $geminiSettings -Force
  Write-Host "OK: Created .gemini/settings.json"
}

$projectGemini = Join-Path $projectPath "GEMINI.md"
$kitGemini = Join-Path $kitDir "GEMINI.md"
if ((-not (Test-Path $projectGemini)) -and (Test-Path $kitGemini)) {
  Copy-Item -LiteralPath $kitGemini -Destination $projectGemini -Force
  Write-Host "OK: Created GEMINI.md"
}

Write-Host ""
Write-Host "Sync complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open any agent in this project"
Write-Host "  2. Use: /bug, /ui fix mobile navbar, /mode frontend, or /use debugging security"
