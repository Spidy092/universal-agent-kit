#!/usr/bin/env bash
set -euo pipefail

TARGET="${HOME}/.ai-agents"
mkdir -p "$TARGET"
cp -R AGENTS.md CLAUDE.md .agents docs "$TARGET/"

echo "Installed global agent kit to $TARGET"
echo "For a project: cp $TARGET/AGENTS.md ./AGENTS.md"
