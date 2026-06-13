#!/usr/bin/env bash
set -euo pipefail

# Universal Agent Kit - File Validator
# Validates all agent configuration files are present and well-formed.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT_DIR="$(dirname "$SCRIPT_DIR")"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ERRORS=0
WARNINGS=0

error() {
  ERRORS=$((ERRORS + 1))
  echo -e "${RED}ERROR:${NC} $1"
}

warn() {
  WARNINGS=$((WARNINGS + 1))
  echo -e "${YELLOW}WARN:${NC} $1"
}

ok() {
  echo -e "${GREEN}OK:${NC} $1"
}

echo "Validating Universal Agent Kit..."
echo ""

# Check required files
REQUIRED_FILES=(
  "AGENTS.md"
  "VERSION"
  "README.md"
  "install-global-agent-kit.sh"
  "install-global-agent-kit.ps1"
  "scripts/install-global.ps1"
  "scripts/sync-agent-context.ps1"
  "scripts/validate-agent-files.ps1"
  ".codex/config.toml"
  ".pi/APPEND_SYSTEM.md"
  ".gemini/settings.json"
)

for f in "${REQUIRED_FILES[@]}"; do
  if [ -f "$KIT_DIR/$f" ]; then
    ok "$f"
  else
    error "Missing required file: $f"
  fi
done

echo ""

# Check skills
echo "Checking skills..."
SKILLS_DIR="$KIT_DIR/.agents/skills"
if [ -d "$SKILLS_DIR" ]; then
  for skill_dir in "$SKILLS_DIR"/*/; do
    skill_name=$(basename "$skill_dir")
    skill_file="$skill_dir/SKILL.md"
    if [ -f "$skill_file" ]; then
      # Check for required frontmatter
      if head -5 "$skill_file" | grep -q "name:"; then
        ok "Skill: $skill_name"
      else
        warn "Skill '$skill_name' missing 'name' in frontmatter"
      fi
    else
      error "Skill '$skill_name' missing SKILL.md"
    fi
  done
else
  error "Skills directory not found"
fi


# Check commands
echo "Checking commands..."
COMMANDS_DIR="$KIT_DIR/.agents/commands"
REQUIRED_COMMANDS=(bug review fix ui security deploy docs refactor test use mode help find-skill)
if [ -d "$COMMANDS_DIR" ]; then
  for command in "${REQUIRED_COMMANDS[@]}"; do
    if [ -f "$COMMANDS_DIR/$command.md" ]; then
      ok "Command: /$command"
    else
      error "Missing command file: .agents/commands/$command.md"
    fi
  done
else
  error "Commands directory not found"
fi

# Check modes
echo ""
echo "Checking modes..."
MODES_DIR="$KIT_DIR/.agents/modes"
REQUIRED_MODES=(strict frontend security production fast)
if [ -d "$MODES_DIR" ]; then
  for mode in "${REQUIRED_MODES[@]}"; do
    if [ -f "$MODES_DIR/$mode.md" ]; then
      ok "Mode: $mode"
    else
      error "Missing mode file: .agents/modes/$mode.md"
    fi
  done
else
  error "Modes directory not found"
fi

echo ""

# Check adapters
echo "Checking adapters..."
ADAPTERS=(
  ".claude/agents/debugger.md"
  ".claude/agents/reviewer.md"
  ".codex/agents/debugger.toml"
  ".codex/agents/reviewer.toml"
  ".opencode/agents/debug.md"
  ".opencode/agents/review.md"
  ".antigravity/instructions.md"
)

for a in "${ADAPTERS[@]}"; do
  if [ -f "$KIT_DIR/$a" ]; then
    ok "Adapter: $a"
  else
    warn "Missing adapter: $a"
  fi
done

echo ""

# Check version format
if [ -f "$KIT_DIR/VERSION" ]; then
  VERSION=$(cat "$KIT_DIR/VERSION")
  if echo "$VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    ok "VERSION format: $VERSION"
  else
    warn "VERSION not in semver format: $VERSION"
  fi
fi

echo ""

# Summary
echo "================================"
if [ $ERRORS -gt 0 ]; then
  echo -e "${RED}Validation failed: $ERRORS errors, $WARNINGS warnings${NC}"
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo -e "${YELLOW}Validation passed with $WARNINGS warnings${NC}"
  exit 0
else
  echo -e "${GREEN}All validations passed!${NC}"
  exit 0
fi
