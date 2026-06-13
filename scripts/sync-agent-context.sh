#!/usr/bin/env bash
set -euo pipefail

mkdir -p .claude .opencode .codex/agents .claude/agents .opencode/agents .pi

cp AGENTS.md CLAUDE.md

rm -rf .claude/skills .opencode/skills
ln -s ../.agents/skills .claude/skills
ln -s ../.agents/skills .opencode/skills

echo "Synced AGENTS.md -> CLAUDE.md and linked shared skills."
