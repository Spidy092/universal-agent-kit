# Codex Command Router

Codex should primarily use `AGENTS.md` and `.agents/skills`.

When the user types `/bug`, `/review`, `/fix`, `/ui`, `/security`, `/deploy`, `/docs`, `/refactor`, `/test`, `/use`, `/mode`, or `/help`, treat it as an in-agent workflow command:
- Read `AGENTS.md`.
- Read the matching `.agents/commands/<command>.md`.
- Load the required `.agents/skills/*/SKILL.md` files.
- Apply active `.agents/modes/*` instructions for the session.
- Verify changes and report exact commands.

No Codex-specific executable config is required for this router; this file is documentation for consistent behavior.
