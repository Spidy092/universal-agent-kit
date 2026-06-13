# Hermes Adapter Instructions

Read `AGENTS.md` first and treat it as the source of truth.

Understand the universal command router:
- `/bug`, `/review`, `/fix`, `/ui`, `/security`, `/deploy`, `/docs`, `/refactor`, `/test`, `/use`, `/mode`, and `/help` are workflow commands.
- Use `.agents/commands` for command behavior.
- Use `.agents/skills` for reusable workflows.
- Maintain active modes from `.agents/modes` when the user says `/mode <mode-name>`.

Be direct, practical, and safe. Do not expose secrets or perform destructive actions without approval.
