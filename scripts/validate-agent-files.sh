#!/usr/bin/env bash
set -euo pipefail

fail=0
warn=0

require_file() {
  if [ -f "$1" ]; then
    echo "ok: $1"
  else
    echo "missing: $1"
    fail=1
  fi
}

require_dir() {
  if [ -d "$1" ]; then
    echo "ok: $1/"
  else
    echo "missing: $1/"
    fail=1
  fi
}

warn_file() {
  if [ -f "$1" ]; then
    echo "ok: $1"
  else
    echo "warning: optional adapter missing: $1"
    warn=1
  fi
}

warn_dir() {
  if [ -d "$1" ]; then
    echo "ok: $1/"
  else
    echo "warning: optional adapter missing: $1/"
    warn=1
  fi
}

require_file AGENTS.md
require_dir .agents/skills
require_dir .agents/commands
require_dir .agents/modes
require_file .agents/commands/bug.md
require_file .agents/commands/use.md
require_file .agents/modes/strict.md
require_file .agents/modes/production.md
require_file scripts/sync-agent-adapters.sh
require_file install-global-agent-kit.sh

missing_frontmatter=0
while IFS= read -r f; do
  grep -q '^name:' "$f" || { echo "Missing name frontmatter in $f"; missing_frontmatter=1; }
  grep -q '^description:' "$f" || { echo "Missing description frontmatter in $f"; missing_frontmatter=1; }
done < <(find .agents/skills -mindepth 2 -maxdepth 2 -name SKILL.md | sort)

if [ "$missing_frontmatter" -ne 0 ]; then
  fail=1
fi

required_skills=(debugging code-review testing refactor devops-deploy security-audit frontend-ui docs-research rtk-prompting caveman-fast-fix)
for s in "${required_skills[@]}"; do
  require_file ".agents/skills/$s/SKILL.md"
done

warn_dir .opencode/commands
warn_dir .claude/skills
warn_file GEMINI.md
warn_file ANTIGRAVITY.md
warn_file .pi/APPEND_SYSTEM.md
warn_file .codex/COMMANDS.md
warn_file docs/hermes-setup.md
warn_file scripts/doctor.sh

if [ "$fail" -ne 0 ]; then
  echo "Agent file validation failed."
  exit 1
fi

if [ "$warn" -ne 0 ]; then
  echo "Agent files valid with optional adapter warnings."
else
  echo "Agent files valid."
fi
