#!/usr/bin/env bash
set -euo pipefail

# Universal Agent Kit - Global Installer
# Run this from inside the universal-agent-kit folder:
#   bash install-global-agent-kit.sh

CURRENT_DIR="$(pwd)"
TARGET="${AI_AGENTS_HOME:-$HOME/.ai-agents}"
BIN_DIR="${HOME}/.local/bin"
INIT_CMD="${BIN_DIR}/agent-init"
UPDATE_CMD="${BIN_DIR}/agent-kit-update"
AGENT_CMD="${BIN_DIR}/agent"

if [ ! -f "${CURRENT_DIR}/AGENTS.md" ]; then
  echo "ERROR: Run this script from inside the universal-agent-kit folder."
  echo "Example:"
  echo "  cd ~/Downloads/universal-agent-kit"
  echo "  bash install-global-agent-kit.sh"
  exit 1
fi

mkdir -p "$TARGET" "$BIN_DIR"
cp -R "${CURRENT_DIR}/." "$TARGET/"

if [ -f "${CURRENT_DIR}/bin/agent" ]; then
  cp "${CURRENT_DIR}/bin/agent" "$AGENT_CMD"
  chmod +x "$AGENT_CMD"
  echo "Installed optional helper: $AGENT_CMD"
fi

cat > "$INIT_CMD" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

FORCE=0
if [ "${1:-}" = "--force" ]; then
  FORCE=1
elif [ "${1:-}" != "" ]; then
  echo "Usage: agent-init [--force]"
  exit 1
fi

KIT="${AI_AGENTS_HOME:-$HOME/.ai-agents}"
PROJECT_DIR="$(pwd)"

if [ ! -f "$KIT/AGENTS.md" ]; then
  echo "ERROR: Global agent kit not found at $KIT"
  echo "Install it first:"
  echo "  cd ~/Downloads/universal-agent-kit"
  echo "  bash install-global-agent-kit.sh"
  exit 1
fi

created=0
skipped=0

note_created() { echo "Created/updated $1"; created=$((created + 1)); }
note_skipped() { echo "$1 already exists, not overwritten."; skipped=$((skipped + 1)); }

copy_file_safe() {
  src="$1"
  dest="$2"
  if [ ! -f "$src" ]; then
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    note_skipped "$dest"
    return 0
  fi
  cp "$src" "$dest"
  note_created "$dest"
}

copy_dir_safe() {
  src="$1"
  dest="$2"
  if [ ! -d "$src" ]; then
    return 0
  fi
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    note_skipped "$dest"
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ]; then
    cp -R "$src/." "$dest/"
  else
    cp -R "$src" "$dest"
  fi
  note_created "$dest"
}

if [ ! -f "$PROJECT_DIR/AGENTS.md" ] || [ "$FORCE" -eq 1 ]; then
  cp "$KIT/AGENTS.md" "$PROJECT_DIR/AGENTS.md"
  note_created "AGENTS.md"
else
  note_skipped "AGENTS.md"
fi

if [ ! -e "$PROJECT_DIR/.agents" ]; then
  ln -s "$KIT/.agents" "$PROJECT_DIR/.agents" 2>/dev/null || cp -R "$KIT/.agents" "$PROJECT_DIR/.agents"
  note_created ".agents"
elif [ "$FORCE" -eq 1 ] && [ -d "$PROJECT_DIR/.agents" ] && [ ! -L "$PROJECT_DIR/.agents" ]; then
  cp -R "$KIT/.agents/." "$PROJECT_DIR/.agents/"
  note_created ".agents"
else
  note_skipped ".agents"
fi

copy_file_safe "$KIT/AGENTS.md" "$PROJECT_DIR/CLAUDE.md"
copy_dir_safe "$KIT/.claude/skills" "$PROJECT_DIR/.claude/skills"
copy_dir_safe "$KIT/.opencode/commands" "$PROJECT_DIR/.opencode/commands"
copy_file_safe "$KIT/.gemini/settings.json" "$PROJECT_DIR/.gemini/settings.json"
copy_file_safe "$KIT/GEMINI.md" "$PROJECT_DIR/GEMINI.md"
copy_file_safe "$KIT/ANTIGRAVITY.md" "$PROJECT_DIR/ANTIGRAVITY.md"
copy_file_safe "$KIT/.antigravity/instructions.md" "$PROJECT_DIR/.antigravity/instructions.md"
copy_file_safe "$KIT/.pi/APPEND_SYSTEM.md" "$PROJECT_DIR/.pi/APPEND_SYSTEM.md"
copy_file_safe "$KIT/docs/hermes-setup.md" "$PROJECT_DIR/docs/hermes-setup.md"
copy_file_safe "$KIT/.hermes/SOUL.md" "$PROJECT_DIR/.hermes/SOUL.md"
copy_file_safe "$KIT/.codex/COMMANDS.md" "$PROJECT_DIR/.codex/COMMANDS.md"
copy_file_safe "$KIT/scripts/sync-agent-adapters.sh" "$PROJECT_DIR/scripts/sync-agent-adapters.sh"
copy_file_safe "$KIT/scripts/validate-agent-files.sh" "$PROJECT_DIR/scripts/validate-agent-files.sh"
copy_file_safe "$KIT/scripts/doctor.sh" "$PROJECT_DIR/scripts/doctor.sh"

chmod +x "$PROJECT_DIR/scripts/sync-agent-adapters.sh" "$PROJECT_DIR/scripts/validate-agent-files.sh" "$PROJECT_DIR/scripts/doctor.sh" 2>/dev/null || true

if [ -x "$PROJECT_DIR/scripts/sync-agent-adapters.sh" ]; then
  if [ "$FORCE" -eq 1 ]; then
    bash "$PROJECT_DIR/scripts/sync-agent-adapters.sh" --force
  else
    bash "$PROJECT_DIR/scripts/sync-agent-adapters.sh"
  fi
fi

echo ""
echo "Done. $created created/updated, $skipped skipped."
echo "Inside any agent, try:"
echo "/bug"
echo "/review"
echo "/fix add login validation"
echo "/mode strict"
echo "/use debugging security"
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
  echo "ERROR: $SOURCE does not look like a universal-agent-kit folder."
  exit 1
fi

mkdir -p "$KIT"
cp -R "$SOURCE/." "$KIT/"
echo "Updated global agent kit at $KIT"
EOF

chmod +x "$INIT_CMD" "$UPDATE_CMD"
chmod +x "$TARGET/scripts/"*.sh 2>/dev/null || true

SHELL_RC="${HOME}/.bashrc"
if [ -n "${ZSH_VERSION:-}" ]; then
  SHELL_RC="${HOME}/.zshrc"
fi

if ! echo "$PATH" | tr ':' '\n' | grep -qx "$BIN_DIR"; then
  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  fi
fi

echo ""
echo "Installed global kit to: $TARGET"
echo "Installed command: $INIT_CMD"
if [ -f "$AGENT_CMD" ]; then
  echo "Installed optional helper: $AGENT_CMD"
fi
echo ""
echo "Restart terminal OR run:"
echo "  export PATH=\"$HOME/.local/bin:$PATH\""
echo ""
echo "For any project:"
echo "  cd /path/to/project"
echo "  agent-init"
echo ""
echo "Inside any agent, try:"
echo "/bug"
echo "/review"
echo "/fix add login validation"
echo "/mode strict"
echo "/use debugging security"
