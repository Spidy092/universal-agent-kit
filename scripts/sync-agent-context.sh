#!/usr/bin/env bash
set -euo pipefail

# Universal Agent Kit - Sync Agent Context
# Syncs AGENTS.md to all agent adapters and creates/updates symlinks.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="${1:-.}"

GREEN='\033[0;32m'
NC='\033[0m'

echo "Syncing agent context in: $PROJECT_DIR"
echo ""

# Create directories
mkdir -p "$PROJECT_DIR/.claude" \
         "$PROJECT_DIR/.opencode" \
         "$PROJECT_DIR/.codex/agents" \
         "$PROJECT_DIR/.claude/agents" \
         "$PROJECT_DIR/.opencode/agents" \
         "$PROJECT_DIR/.pi"

# Copy AGENTS.md to CLAUDE.md
cp "$PROJECT_DIR/AGENTS.md" "$PROJECT_DIR/CLAUDE.md"
echo -e "${GREEN}✓${NC} Synced AGENTS.md -> CLAUDE.md"

# Link skills
if [ ! -e "$PROJECT_DIR/.claude/skills" ]; then
  ln -s ../.agents/skills "$PROJECT_DIR/.claude/skills" 2>/dev/null || \
    cp -R "$PROJECT_DIR/.agents/skills" "$PROJECT_DIR/.claude/skills"
  echo -e "${GREEN}✓${NC} Linked .claude/skills"
fi

if [ ! -e "$PROJECT_DIR/.opencode/skills" ]; then
  ln -s ../.agents/skills "$PROJECT_DIR/.opencode/skills" 2>/dev/null || \
    cp -R "$PROJECT_DIR/.agents/skills" "$PROJECT_DIR/.opencode/skills"
  echo -e "${GREEN}✓${NC} Linked .opencode/skills"
fi

# Copy Gemini config if not exists
if [ ! -f "$PROJECT_DIR/.gemini/settings.json" ] && [ -f "$KIT_DIR/.gemini/settings.json" ]; then
  mkdir -p "$PROJECT_DIR/.gemini"
  cp "$KIT_DIR/.gemini/settings.json" "$PROJECT_DIR/.gemini/settings.json"
  echo -e "${GREEN}✓${NC} Created .gemini/settings.json"
fi

# Copy GEMINI.md if not exists
if [ ! -f "$PROJECT_DIR/GEMINI.md" ] && [ -f "$KIT_DIR/GEMINI.md" ]; then
  cp "$KIT_DIR/GEMINI.md" "$PROJECT_DIR/GEMINI.md"
  echo -e "${GREEN}✓${NC} Created GEMINI.md"
fi

echo ""
echo "Sync complete!"
echo ""
echo "Next steps:"
echo "  1. Open any agent in this project"
echo "  2. Use: /bug, /ui fix mobile navbar, /mode frontend, or /use debugging security"
