#!/usr/bin/env bash
set -euo pipefail

check_file() {
  if [ -f "$1" ]; then
    echo "ok: $1"
  else
    echo "missing: $1"
  fi
}

check_dir() {
  if [ -d "$1" ]; then
    echo "ok: $1/"
  else
    echo "missing: $1/"
  fi
}

echo "Universal Agent Kit Doctor"
echo ""

echo "Global install:"
if [ -d "${AI_AGENTS_HOME:-$HOME/.ai-agents}" ]; then
  echo "ok: ${AI_AGENTS_HOME:-$HOME/.ai-agents}"
else
  echo "missing: ${AI_AGENTS_HOME:-$HOME/.ai-agents}"
fi
if command -v agent-init >/dev/null 2>&1; then
  echo "ok: agent-init at $(command -v agent-init)"
else
  echo "missing: agent-init on PATH"
fi
if command -v agent >/dev/null 2>&1; then
  echo "ok: agent at $(command -v agent)"
else
  echo "optional: agent helper not installed"
fi

echo ""
echo "Project install:"
check_file AGENTS.md
check_file CLAUDE.md
check_dir .agents/skills
check_dir .agents/commands
check_dir .agents/modes
check_file .agents/commands/bug.md
check_file .agents/commands/use.md
check_file .agents/modes/strict.md
check_file .agents/modes/production.md

echo ""
echo "Adapters:"
check_dir .opencode/commands
check_dir .claude/skills
check_file GEMINI.md
check_file .gemini/settings.json
check_file ANTIGRAVITY.md
check_file .antigravity/instructions.md
check_file .pi/APPEND_SYSTEM.md
check_file .codex/COMMANDS.md
check_file docs/hermes-setup.md

echo ""
echo "Suggested fix:"
echo "  bash scripts/sync-agent-adapters.sh"
echo "  bash scripts/validate-agent-files.sh"
