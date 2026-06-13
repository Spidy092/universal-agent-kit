#!/usr/bin/env bash
set -euo pipefail

TARGET="${HOME}/.ai-agents"
mkdir -p "$TARGET"
cp -R AGENTS.md CLAUDE.md install-global-agent-kit.ps1 .agents docs "$TARGET/"

cat <<EOF
Installed global agent kit to $TARGET

For each project, run:
  agent-init

Then open any coding agent and use:
  /bug
  /ui fix mobile navbar
  /mode frontend
  /use debugging security
EOF
