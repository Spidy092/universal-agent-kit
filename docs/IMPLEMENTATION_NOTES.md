# Implementation Notes

## Universal Pieces

`AGENTS.md` is the always-on project contract. It defines safety, verification, routing, output formats, and how to combine skills.

`.agents/skills/*/SKILL.md` contains reusable workflows. These are the main behavior units.

`.agents/commands/*.md` maps simple in-agent commands such as `/bug` and `/review` to one or more skills.

`.agents/modes/*.md` defines session-wide behavior such as strict, frontend, production, or fast mode.

## Adapter Pieces

Adapters make the same workflow visible to different coding agents:
- `.claude/skills/*/SKILL.md` gives Claude directly loadable skill wrappers.
- `.opencode/commands/*.md` gives OpenCode command files with `$ARGUMENTS` placeholders.
- `GEMINI.md` and `.gemini/settings.json` ask Gemini to load the project contract.
- `ANTIGRAVITY.md` and `.antigravity/instructions.md` describe router behavior and safety rules.
- `.pi/APPEND_SYSTEM.md` gives Pi the same command and mode contract.
- `.hermes/SOUL.md` or `docs/hermes-setup.md` gives Hermes a plain-text adapter.
- `.codex/COMMANDS.md` documents how Codex should interpret workflow commands.

## Native Support and Fallback

Not every agent supports slash commands or project config the same way. The fallback is simple: even if slash commands are not native, `AGENTS.md` teaches the agent to treat `/bug`, `/review`, `/mode strict`, and similar messages as workflow commands.

Adapters should stay short. They point back to `.agents/commands`, `.agents/modes`, and `.agents/skills` instead of duplicating large workflows.

## Sync Behavior

`scripts/sync-agent-adapters.sh` creates required folders and copies adapter files where safe. By default it skips existing files. Use `--force` only when you intentionally want to overwrite adapter files with the kit version.

`agent-init` should also avoid overwriting project-specific files unless explicitly forced.
