#!/usr/bin/env bash
set -euo pipefail

VERSION=$(cat "$(dirname "$0")/VERSION" 2>/dev/null || echo "unknown")

# Universal Agent Kit - Global Installer
# Run this from inside the extracted universal-agent-kit folder:
#   bash install-global-agent-kit.sh

show_help() {
  cat <<'HELP'
Universal Agent Kit - Global Installer

Usage:
  bash install-global-agent-kit.sh [OPTIONS]

Options:
  --help, -h        Show this help message
  --version, -v     Show version
  --force, -f       Force reinstall even if already installed
  --uninstall       Remove global installation

Examples:
  bash install-global-agent-kit.sh              # Normal install
  bash install-global-agent-kit.sh --force      # Reinstall/upgrade
  bash install-global-agent-kit.sh --uninstall  # Remove completely

After install:
  cd /path/to/project
  agent-init              # Initialize project
  agent-init --help       # Show agent-init help
  agent-init --rollback   # Undo agent-init in a project
HELP
}

show_version() {
  echo "Universal Agent Kit v${VERSION}"
}

FORCE=false
UNINSTALL=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h)
      show_help
      exit 0
      ;;
    --version|-v)
      show_version
      exit 0
      ;;
    --force|-f)
      FORCE=true
      shift
      ;;
    --uninstall)
      UNINSTALL=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

CURRENT_DIR="$(pwd)"
TARGET="${HOME}/.ai-agents"
BIN_DIR="${HOME}/.local/bin"
INIT_CMD="${BIN_DIR}/agent-init"
UPDATE_CMD="${BIN_DIR}/agent-kit-update"

# Uninstall mode
if [ "$UNINSTALL" = true ]; then
  echo "Uninstalling Universal Agent Kit..."
  rm -rf "$TARGET"
  rm -f "$INIT_CMD" "$UPDATE_CMD"
  echo "Removed: $TARGET"
  echo "Removed: $INIT_CMD"
  echo "Removed: $UPDATE_CMD"
  echo "Done. You may also remove PATH entry from your shell rc file."
  exit 0
fi

if [ ! -f "${CURRENT_DIR}/AGENTS.md" ]; then
  echo "ERROR: Run this script from inside the extracted universal-agent-kit folder."
  echo "Example:"
  echo "  cd ~/Downloads/universal-agent-kit"
  echo "  bash install-global-agent-kit.sh"
  exit 1
fi

# Check if already installed
if [ -d "$TARGET" ] && [ "$FORCE" = false ]; then
  echo "Universal Agent Kit already installed at $TARGET"
  echo "Use --force to reinstall/upgrade"
  exit 0
fi

mkdir -p "$TARGET" "$BIN_DIR"

# Copy the reusable global kit once.
cp -R "${CURRENT_DIR}/." "$TARGET/"

cat > "$INIT_CMD" <<'INIT_EOF'
#!/usr/bin/env bash
set -euo pipefail

VERSION_FILE="${AI_AGENTS_HOME:-$HOME/.ai-agents}/VERSION"
VERSION=$(cat "$VERSION_FILE" 2>/dev/null || echo "unknown")

show_help() {
  cat <<'HELP'
Universal Agent Kit - Project Initializer

Usage:
  agent-init [OPTIONS]

Options:
  --help, -h        Show this help message
  --version, -v     Show version
  --rollback, -r    Undo agent-init (remove created files/links)
  --dry-run         Show what would be done without doing it
  --force           Overwrite existing files

Examples:
  agent-init                    # Initialize current project
  agent-init --dry-run          # Preview changes
  agent-init --rollback         # Undo initialization
  agent-init --force            # Reinitialize (overwrite)
HELP
}

show_version() {
  echo "Universal Agent Kit v${VERSION}"
}

rollback() {
  PROJECT_DIR="$(pwd)"
  echo "Rolling back agent-init in: $PROJECT_DIR"
  
  # Only remove files/links we created
  [ -L "$PROJECT_DIR/.agents" ] && rm -f "$PROJECT_DIR/.agents" && echo "Removed: .agents (symlink)"
  [ -L "$PROJECT_DIR/.claude" ] && rm -f "$PROJECT_DIR/.claude" && echo "Removed: .claude (symlink)"
  [ -L "$PROJECT_DIR/.codex" ] && rm -f "$PROJECT_DIR/.codex" && echo "Removed: .codex (symlink)"
  [ -L "$PROJECT_DIR/.opencode" ] && rm -f "$PROJECT_DIR/.opencode" && echo "Removed: .opencode (symlink)"
  [ -L "$PROJECT_DIR/.pi" ] && rm -f "$PROJECT_DIR/.pi" && echo "Removed: .pi (symlink)"
  
  # Ask before removing AGENTS.md (user may have customized it)
  if [ -f "$PROJECT_DIR/AGENTS.md" ]; then
    read -p "Remove AGENTS.md? (may contain custom project rules) [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -f "$PROJECT_DIR/AGENTS.md" && echo "Removed: AGENTS.md"
    else
      echo "Kept: AGENTS.md"
    fi
  fi
  
  if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    read -p "Remove CLAUDE.md? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -f "$PROJECT_DIR/CLAUDE.md" && echo "Removed: CLAUDE.md"
    else
      echo "Kept: CLAUDE.md"
    fi
  fi
  
  echo ""
  echo "Rollback complete."
}

DRY_RUN=false
DO_ROLLBACK=false
DO_FORCE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h)
      show_help
      exit 0
      ;;
    --version|-v)
      show_version
      exit 0
      ;;
    --rollback|-r)
      DO_ROLLBACK=true
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --force)
      DO_FORCE=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

if [ "$DO_ROLLBACK" = true ]; then
  rollback
  exit 0
fi

KIT="${AI_AGENTS_HOME:-$HOME/.ai-agents}"

if [ ! -f "$KIT/AGENTS.md" ]; then
  echo "ERROR: Global agent kit not found at $KIT"
  echo "Install it first:"
  echo "  cd ~/Downloads/universal-agent-kit"
  echo "  bash install-global-agent-kit.sh"
  exit 1
fi

PROJECT_DIR="$(pwd)"

if [ "$DRY_RUN" = true ]; then
  echo "DRY RUN - Would create/link in: $PROJECT_DIR"
  [ ! -f "$PROJECT_DIR/AGENTS.md" ] && echo "  + AGENTS.md"
  [ ! -e "$PROJECT_DIR/.agents" ] && echo "  + .agents -> global skills"
  [ ! -f "$PROJECT_DIR/CLAUDE.md" ] && echo "  + CLAUDE.md"
  [ ! -e "$PROJECT_DIR/.claude" ] && echo "  + .claude/skills"
  for d in .codex .opencode .pi; do
    [ ! -e "$PROJECT_DIR/$d" ] && echo "  + $d"
  done
  exit 0
fi

# Create project AGENTS.md only if it doesn't already exist (or force).
if [ ! -f "$PROJECT_DIR/AGENTS.md" ] || [ "$DO_FORCE" = true ]; then
  cat > "$PROJECT_DIR/AGENTS.md" <<'PROJECT_EOF'
# Project Agent Rules

This project uses my global AI agent kit.

Use this file as the command router and source of truth.
Global workflows live here:
`~/.ai-agents/.agents`

## Command Router

Inside any coding agent, use short workflow commands:

```txt
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
```

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

```md
## Summary
## What I found
## Fix / Changes
## Files changed
## Commands to run
## Verification
## Risks / Edge cases
```
PROJECT_EOF
  echo "Created AGENTS.md"
else
  echo "AGENTS.md already exists, not overwritten. (use --force to overwrite)"
fi

# Link shared skills into project so agents can discover them locally.
if [ ! -e "$PROJECT_DIR/.agents" ]; then
  ln -s "$KIT/.agents" "$PROJECT_DIR/.agents" 2>/dev/null || cp -R "$KIT/.agents" "$PROJECT_DIR/.agents"
  echo "Linked .agents -> global skills"
else
  echo ".agents already exists, not changed."
fi

# Claude compatibility
if [ ! -f "$PROJECT_DIR/CLAUDE.md" ] || [ "$DO_FORCE" = true ]; then
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
echo "Done. (v${VERSION})"
echo "Now open any agent in this project and use:"
echo "  /bug"
echo "  /ui fix mobile navbar"
echo "  /mode frontend"
echo "  /use debugging security"
echo "  /find-skill whatsapp automation"
INIT_EOF

cat > "$UPDATE_CMD" <<'UPDATE_EOF'
#!/usr/bin/env bash
set -euo pipefail

KIT="${AI_AGENTS_HOME:-$HOME/.ai-agents}"
SOURCE="${1:-}"

if [ -z "$SOURCE" ] || [ "$SOURCE" = "--help" ] || [ "$SOURCE" = "-h" ]; then
  echo "Universal Agent Kit - Updater"
  echo ""
  echo "Usage:"
  echo "  agent-kit-update /path/to/new/universal-agent-kit"
  echo ""
  echo "Updates the global kit from a new source."
  exit 0
fi

if [ ! -f "$SOURCE/AGENTS.md" ]; then
  echo "ERROR: $SOURCE does not look like universal-agent-kit folder."
  exit 1
fi

mkdir -p "$KIT"
cp -R "$SOURCE/." "$KIT/"
echo "Updated global agent kit at $KIT"
UPDATE_EOF

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
echo "Installed Universal Agent Kit v${VERSION} to: $TARGET"
echo "Installed command: $INIT_CMD"
echo ""
echo "Restart terminal OR run:"
echo "  export PATH=\"$HOME/.local/bin:$PATH\""
echo ""
echo "For any project:"
echo "  cd /path/to/project"
echo "  agent-init"
