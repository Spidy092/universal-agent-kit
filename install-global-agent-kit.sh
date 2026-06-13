#!/usr/bin/env bash
set -euo pipefail

# Universal Agent Kit - Global Installer
# Run this from inside the extracted universal-agent-kit folder:
#   bash install-global-agent-kit.sh

CURRENT_DIR="$(pwd)"
TARGET="${HOME}/.ai-agents"
BIN_DIR="${HOME}/.local/bin"
INIT_CMD="${BIN_DIR}/agent-init"
UPDATE_CMD="${BIN_DIR}/agent-kit-update"

if [ ! -f "${CURRENT_DIR}/AGENTS.md" ]; then
  echo "ERROR: Run this script from inside the extracted universal-agent-kit folder."
  echo "Example:"
  echo "  cd ~/Downloads/universal-agent-kit"
  echo "  bash install-global-agent-kit.sh"
  exit 1
fi

mkdir -p "$TARGET" "$BIN_DIR"

# Copy the reusable global kit once.
cp -R "${CURRENT_DIR}/." "$TARGET/"

cat > "$INIT_CMD" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

KIT="${AI_AGENTS_HOME:-$HOME/.ai-agents}"

if [ ! -f "$KIT/AGENTS.md" ]; then
  echo "ERROR: Global agent kit not found at $KIT"
  echo "Install it first:"
  echo "  cd ~/Downloads/universal-agent-kit"
  echo "  bash install-global-agent-kit.sh"
  exit 1
fi

PROJECT_DIR="$(pwd)"

# Create project AGENTS.md only if it doesn't already exist.
if [ ! -f "$PROJECT_DIR/AGENTS.md" ]; then
  cat > "$PROJECT_DIR/AGENTS.md" <<PROJECT_EOF
# Project Agent Rules

This project uses my global AI agent kit.

Global reusable skills live here:
\`~/.ai-agents/.agents/skills\`

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

## Rules

- Read existing code before changing.
- Make the smallest safe change.
- Do not rewrite unrelated code.
- Do not delete files, reset DB, or force push without asking.
- Give exact files changed.
- Give exact commands to test.
- Mention edge cases.
- Use global skills when relevant:
  - debugging
  - code-review
  - testing
  - refactor
  - devops-deploy
  - security-audit
  - frontend-ui
  - docs-research
  - rtk-prompting
  - caveman-fast-fix

## Output Format

For serious work:

\`\`\`md
## Summary
## What I found
## Fix / Changes
## Files changed
## Commands to run
## Verification
## Risks / Edge cases
\`\`\`
PROJECT_EOF
  echo "Created AGENTS.md"
else
  echo "AGENTS.md already exists, not overwritten."
fi

# Link shared skills into project so agents can discover them locally.
if [ ! -e "$PROJECT_DIR/.agents" ]; then
  ln -s "$KIT/.agents" "$PROJECT_DIR/.agents" 2>/dev/null || cp -R "$KIT/.agents" "$PROJECT_DIR/.agents"
  echo "Linked .agents -> global skills"
else
  echo ".agents already exists, not changed."
fi

# Claude compatibility
if [ ! -f "$PROJECT_DIR/CLAUDE.md" ]; then
  cp "$PROJECT_DIR/AGENTS.md" "$PROJECT_DIR/CLAUDE.md"
  echo "Created CLAUDE.md"
else
  echo "CLAUDE.md already exists, not overwritten."
fi

if [ ! -e "$PROJECT_DIR/.claude" ]; then
  mkdir -p "$PROJECT_DIR/.claude"
  ln -s ../.agents/skills "$PROJECT_DIR/.claude/skills" 2>/dev/null || cp -R "$PROJECT_DIR/.agents/skills" "$PROJECT_DIR/.claude/skills"
  echo "Created .claude/skills"
fi

# Optional adapters for Codex/OpenCode/Pi if available in global kit.
for d in .codex .opencode .pi; do
  if [ -d "$KIT/$d" ] && [ ! -e "$PROJECT_DIR/$d" ]; then
    ln -s "$KIT/$d" "$PROJECT_DIR/$d" 2>/dev/null || cp -R "$KIT/$d" "$PROJECT_DIR/$d"
    echo "Linked $d"
  fi
done

echo ""
echo "Done."
echo "Now open any agent in this project and say:"
echo "  Read AGENTS.md first. Use the matching skill from .agents/skills."
EOF

cat > "$UPDATE_CMD" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

KIT="${AI_AGENTS_HOME:-$HOME/.ai-agents}"
SOURCE="${1:-}"

if [ -z "$SOURCE" ]; then
  echo "Usage:"
  echo "  agent-kit-update /path/to/new/universal-agent-kit"
  exit 1
fi

if [ ! -f "$SOURCE/AGENTS.md" ]; then
  echo "ERROR: $SOURCE does not look like universal-agent-kit folder."
  exit 1
fi

mkdir -p "$KIT"
cp -R "$SOURCE/." "$KIT/"
echo "Updated global agent kit at $KIT"
EOF

chmod +x "$INIT_CMD" "$UPDATE_CMD"

# Ensure ~/.local/bin in shell path.
SHELL_RC=""
if [ -n "${ZSH_VERSION:-}" ]; then
  SHELL_RC="${HOME}/.zshrc"
else
  SHELL_RC="${HOME}/.bashrc"
fi

if ! echo "$PATH" | tr ':' '\n' | grep -qx "$BIN_DIR"; then
  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  fi
fi

echo ""
echo "Installed global kit to: $TARGET"
echo "Installed command: $INIT_CMD"
echo ""
echo "Restart terminal OR run:"
echo "  export PATH=\"$HOME/.local/bin:$PATH\""
echo ""
echo "For any project:"
echo "  cd /path/to/project"
echo "  agent-init"
