#!/usr/bin/env bash
set -euo pipefail

# Universal Agent Kit - Test Suite
# Run: bash tests/run-tests.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT_DIR="$(dirname "$SCRIPT_DIR")"
PASS=0
FAIL=0
TESTS=()

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() {
  PASS=$((PASS + 1))
  echo -e "${GREEN}✓${NC} $1"
}

fail() {
  FAIL=$((FAIL + 1))
  echo -e "${RED}✗${NC} $1"
}

check() {
  if eval "$2"; then
    pass "$1"
  else
    fail "$1"
  fi
}

echo "================================"
echo " Universal Agent Kit Test Suite"
echo "================================"
echo ""

# --- File Structure Tests ---
echo "📁 File Structure Tests"
echo "------------------------"

check "AGENTS.md exists" "[ -f '$KIT_DIR/AGENTS.md' ]"
check "VERSION file exists" "[ -f '$KIT_DIR/VERSION' ]"
check "VERSION is semver" "grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$' '$KIT_DIR/VERSION'"
check "README.md exists" "[ -f '$KIT_DIR/README.md' ]"
check "USAGE_GUIDE.md exists" "[ -f '$KIT_DIR/USAGE_GUIDE.md' ]"
check "install script exists" "[ -f '$KIT_DIR/install-global-agent-kit.sh' ]"
check "install script is executable" "[ -x '$KIT_DIR/install-global-agent-kit.sh' ]"

echo ""

# --- Skills Tests ---
echo "🛠️  Skills Tests"
echo "----------------"

REQUIRED_SKILLS=("debugging" "code-review" "testing" "refactor" "devops-deploy" "security-audit" "frontend-ui" "docs-research" "rtk-prompting" "caveman-fast-fix" "api-design" "database-migration" "performance-optimization" "find-skills")

for skill in "${REQUIRED_SKILLS[@]}"; do
  check "Skill '$skill' exists" "[ -f '$KIT_DIR/.agents/skills/$skill/SKILL.md' ]"
  check "Skill '$skill' has name" "head -10 '$KIT_DIR/.agents/skills/$skill/SKILL.md' | grep -q 'name:'"
  check "Skill '$skill' has description" "head -10 '$KIT_DIR/.agents/skills/$skill/SKILL.md' | grep -q 'description:'"
done

echo ""


# --- Commands Tests ---
echo "⌨️  Commands Tests"
echo "-------------------"

REQUIRED_COMMANDS=("bug" "review" "fix" "ui" "security" "deploy" "docs" "refactor" "test" "use" "mode" "help" "find-skill")

for command in "${REQUIRED_COMMANDS[@]}"; do
  check "Command '$command' exists" "[ -f '$KIT_DIR/.agents/commands/$command.md' ]"
done

echo ""

# --- Modes Tests ---
echo "🎚️  Modes Tests"
echo "---------------"

REQUIRED_MODES=("strict" "frontend" "security" "production" "fast")

for mode in "${REQUIRED_MODES[@]}"; do
  check "Mode '$mode' exists" "[ -f '$KIT_DIR/.agents/modes/$mode.md' ]"
done

echo ""

# --- Adapter Tests ---
echo "🔌 Adapter Tests"
echo "----------------"

check "Claude adapter (CLAUDE.md)" "[ -f '$KIT_DIR/CLAUDE.md' ]"
check "Claude subagents dir" "[ -d '$KIT_DIR/.claude/agents' ]"
check "Claude debugger agent" "[ -f '$KIT_DIR/.claude/agents/debugger.md' ]"
check "Claude reviewer agent" "[ -f '$KIT_DIR/.claude/agents/reviewer.md' ]"
check "Codex config" "[ -f '$KIT_DIR/.codex/config.toml' ]"
check "Codex debugger agent" "[ -f '$KIT_DIR/.codex/agents/debugger.toml' ]"
check "Codex reviewer agent" "[ -f '$KIT_DIR/.codex/agents/reviewer.toml' ]"
check "OpenCode debug agent" "[ -f '$KIT_DIR/.opencode/agents/debug.md' ]"
check "OpenCode review agent" "[ -f '$KIT_DIR/.opencode/agents/review.md' ]"
check "Pi adapter" "[ -f '$KIT_DIR/.pi/APPEND_SYSTEM.md' ]"
check "Antigravity adapter" "[ -f '$KIT_DIR/.antigravity/instructions.md' ]"
check "Gemini settings" "[ -f '$KIT_DIR/.gemini/settings.json' ]"
check "Gemini instructions" "[ -f '$KIT_DIR/GEMINI.md' ]"

echo ""

# --- Script Tests ---
echo "📜 Script Tests"
echo "---------------"

check "sync-agent-context.sh exists" "[ -f '$KIT_DIR/scripts/sync-agent-context.sh' ]"
check "validate-agent-files.sh exists" "[ -f '$KIT_DIR/scripts/validate-agent-files.sh' ]"

echo ""

# --- Template Tests ---
echo "📄 Template Tests"
echo "-----------------"

check ".env.example exists" "[ -f '$KIT_DIR/templates/.env.example' ]"
check ".env.example has DATABASE_URL" "grep -q 'DATABASE_URL' '$KIT_DIR/templates/.env.example'"
check ".env.example has JWT_SECRET" "grep -q 'JWT_SECRET' '$KIT_DIR/templates/.env.example'"

echo ""

# --- Content Quality Tests ---
echo "📝 Content Quality Tests"
echo "------------------------"

check "AGENTS.md has safety rules" "grep -q 'Safety' '$KIT_DIR/AGENTS.md'"
check "AGENTS.md has verification rules" "grep -q 'Verification' '$KIT_DIR/AGENTS.md'"
check "AGENTS.md has output format" "grep -q 'Output Format' '$KIT_DIR/AGENTS.md'"
check "AGENTS.md has skill routing" "grep -q 'Skill Routing' '$KIT_DIR/AGENTS.md'"
check "AGENTS.md has command router" "grep -q 'Command Router' '$KIT_DIR/AGENTS.md'"
check "README shows effective workflow" "grep -q 'Effective Workflow' '$KIT_DIR/README.md'"
check "Command files include /bug" "grep -q '/bug' '$KIT_DIR/.agents/commands/bug.md'"
check "Find-skill command exists" "grep -q '/find-skill' '$KIT_DIR/.agents/commands/find-skill.md'"
check "AGENTS.md routes missing skills" "grep -q 'find-skills' '$KIT_DIR/AGENTS.md'"
check "Mode files include frontend" "grep -q 'Mode: frontend' '$KIT_DIR/.agents/modes/frontend.md'"
check "Installer template includes command router" "grep -q 'Command Router' '$KIT_DIR/install-global-agent-kit.sh'"
check "No obsolete manual prompt examples" "! grep -R -n -E 'Read AGENTS\.md and ANTIGRAVITY\.md|Use debugging skill|Use frontend-ui skill|paste the prompt|Find root cause, make smallest safe fix|Verify in browser and provide screenshot/artifact|Read AGENTS\.md first\. Use the matching skill' '$KIT_DIR' --exclude='run-tests.sh' --exclude-dir='.git'"
check "Debugging skill has workflow" "grep -q 'Workflow' '$KIT_DIR/.agents/skills/debugging/SKILL.md'"
check "Code-review has severity levels" "grep -q 'Blocking' '$KIT_DIR/.agents/skills/code-review/SKILL.md'"

echo ""

# --- Integration Test ---
echo "🔗 Integration Test"
echo "-------------------"

TEMP_HOME=$(mktemp -d)
TEMP_PROJECT=$(mktemp -d)
ORIGINAL_DIR="$(pwd)"

cd "$KIT_DIR"
HOME="$TEMP_HOME" bash "$KIT_DIR/install-global-agent-kit.sh" --force >/dev/null

cd "$TEMP_PROJECT"
HOME="$TEMP_HOME" AI_AGENTS_HOME="$TEMP_HOME/.ai-agents" "$TEMP_HOME/.local/bin/agent-init" >/dev/null

check "Integration: AGENTS.md created by agent-init" "[ -f '$TEMP_PROJECT/AGENTS.md' ]"
check "Integration: AGENTS.md has command router" "grep -q 'Command Router' '$TEMP_PROJECT/AGENTS.md'"
check "Integration: AGENTS.md shows /bug" "grep -q '/bug' '$TEMP_PROJECT/AGENTS.md'"
check "Integration: AGENTS.md shows /mode frontend" "grep -q '/mode frontend' '$TEMP_PROJECT/AGENTS.md'"
check "Integration: AGENTS.md shows /use debugging security" "grep -q '/use debugging security' '$TEMP_PROJECT/AGENTS.md'"
check "Integration: AGENTS.md shows /find-skill" "grep -q '/find-skill' '$TEMP_PROJECT/AGENTS.md'"
check "Integration: CLAUDE.md mirrors command router" "grep -q 'Command Router' '$TEMP_PROJECT/CLAUDE.md'"
check "Integration: .agents linked in test dir" "[ -d '$TEMP_PROJECT/.agents' ]"
check "Integration: commands accessible" "[ -f '$TEMP_PROJECT/.agents/commands/bug.md' ]"
check "Integration: find-skill command accessible" "[ -f '$TEMP_PROJECT/.agents/commands/find-skill.md' ]"
check "Integration: modes accessible" "[ -f '$TEMP_PROJECT/.agents/modes/frontend.md' ]"
check "Integration: skills accessible" "[ -d '$TEMP_PROJECT/.agents/skills/debugging' ]"
check "Integration: skill has content" "[ -s '$TEMP_PROJECT/.agents/skills/debugging/SKILL.md' ]"

cd "$ORIGINAL_DIR"
rm -rf "$TEMP_HOME" "$TEMP_PROJECT"

echo ""

# --- Summary ---
echo "================================"
echo " Test Results"
echo "================================"
echo -e " ${GREEN}Passed: $PASS${NC}"
echo -e " ${RED}Failed: $FAIL${NC}"
echo -e " Total:  $((PASS + FAIL))"
echo ""

if [ $FAIL -gt 0 ]; then
  echo -e "${RED}Some tests failed!${NC}"
  exit 1
else
  echo -e "${GREEN}All tests passed!${NC}"
  exit 0
fi
