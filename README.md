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
