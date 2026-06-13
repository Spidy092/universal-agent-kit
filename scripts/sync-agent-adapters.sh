#!/usr/bin/env bash
set -euo pipefail

FORCE=0
if [ "${1:-}" = "--force" ]; then
  FORCE=1
elif [ "${1:-}" != "" ]; then
  echo "Usage: $0 [--force]"
  exit 1
fi

created=0
skipped=0
warned=0

say_create() { echo "created: $1"; created=$((created + 1)); }
say_skip() { echo "skipped: $1"; skipped=$((skipped + 1)); }
say_warn() { echo "warning: $1"; warned=$((warned + 1)); }

ensure_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
    say_create "$1/"
  else
    say_skip "$1/"
  fi
}

copy_file() {
  src="$1"
  dest="$2"
  if [ ! -f "$src" ]; then
    say_warn "missing source $src"
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  if [ "$src" = "$dest" ]; then
    say_skip "$dest"
    return 0
  fi
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    say_skip "$dest"
    return 0
  fi
  cp "$src" "$dest"
  say_create "$dest"
}

copy_tree_files() {
  src_dir="$1"
  dest_dir="$2"
  if [ ! -d "$src_dir" ]; then
    say_warn "missing source directory $src_dir"
    return 0
  fi
  while IFS= read -r src; do
    rel="${src#$src_dir/}"
    copy_file "$src" "$dest_dir/$rel"
  done < <(find "$src_dir" -type f | sort)
}

ensure_dir .agents/commands
ensure_dir .agents/modes
ensure_dir .claude/skills
ensure_dir .opencode/commands
ensure_dir .gemini
ensure_dir .antigravity
ensure_dir .pi
ensure_dir .codex

copy_tree_files .agents/commands .opencode/commands

copy_file GEMINI.md GEMINI.md
copy_file .gemini/settings.json .gemini/settings.json
copy_file ANTIGRAVITY.md ANTIGRAVITY.md
copy_file .antigravity/instructions.md .antigravity/instructions.md
copy_file .pi/APPEND_SYSTEM.md .pi/APPEND_SYSTEM.md
copy_file docs/hermes-setup.md docs/hermes-setup.md
copy_file .codex/COMMANDS.md .codex/COMMANDS.md

if [ -f CLAUDE.md ] && [ "$FORCE" -ne 1 ]; then
  say_skip CLAUDE.md
elif [ -f AGENTS.md ]; then
  cp AGENTS.md CLAUDE.md
  say_create CLAUDE.md
fi

echo ""
echo "Adapter sync complete: $created created/updated, $skipped skipped, $warned warnings."
if [ "$FORCE" -ne 1 ]; then
  echo "Run $0 --force to overwrite existing adapter files."
fi
