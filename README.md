# Universal Agent Kit

Reusable setup for Codex, OpenCode, Claude Code, Pi, Hermes, and custom AI agents.

## Main idea

Do not create separate full skill systems for every agent.

Use:

```txt
AGENTS.md                      -> always-on repo rules
.agents/skills/*/SKILL.md      -> reusable task skills
CLAUDE.md                      -> Claude mirror
.codex/agents/*.toml           -> Codex adapters
.claude/agents/*.md            -> Claude subagents
.opencode/agents/*.md          -> OpenCode agents
.pi/APPEND_SYSTEM.md           -> Pi adapter
scripts/sync-agent-context.sh  -> sync mirrors
scripts/validate-agent-files.sh -> validate files
```

## Install into a project

Copy this kit into your repo root, then run:

```bash
chmod +x scripts/*.sh
./scripts/sync-agent-context.sh
./scripts/validate-agent-files.sh
```

```bash
git clone

cd ~/universal-agent-kit
bash install-global-agent-kit.sh
export PATH="$HOME/.local/bin:$PATH"
```


Open this project in Antigravity and first message should be:

Read AGENTS.md and ANTIGRAVITY.md first.
Use the matching skill from .agents/skills.

For bug fixing:

Read AGENTS.md and ANTIGRAVITY.md.
Use debugging skill.

Here is the error:
[paste error]

Find root cause, make smallest safe fix, and give verification command.


## Effective Workflow System

This kit is an in-agent command, mode, and skill router.

- Skills are reusable workflows in `.agents/skills`.
- Commands are in-agent shortcuts in `.agents/commands`.
- Modes are session-wide behavior files in `.agents/modes`.
- The router decides which skills to use from explicit commands or task auto-detection.
- Adapters make the same system visible to Codex, Claude Code, OpenCode, Pi, Hermes, Gemini, and Antigravity.

Daily examples inside any agent:

```txt
/bug
/review
/fix add login validation
/ui fix mobile navbar
/mode strict
/mode frontend
/use debugging security
/docs check latest OpenWA docs
```

Setup:

```bash
git clone <repo-url> universal-agent-kit
cd universal-agent-kit
bash install-global-agent-kit.sh
cd /path/to/project
agent-init
```

Then open a coding agent in the project and type `/bug`, `/review`, or another workflow command.

See `docs/COMMANDS_AND_MODES.md` for command and mode details.
