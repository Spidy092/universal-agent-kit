# Gemini Agent Instructions

Read `AGENTS.md` first. Treat it as the source of truth.

Support the same in-agent command router used by the universal kit:
- `/bug` or `/debug` routes to `.agents/commands/bug.md` and `.agents/skills/debugging/SKILL.md`.
- `/review` routes to `.agents/commands/review.md` and `.agents/skills/code-review/SKILL.md`.
- `/fix <task>` routes to `.agents/commands/fix.md` and auto-detected skills.
- `/ui` or `/frontend` routes to `.agents/skills/frontend-ui/SKILL.md`.
- `/security` routes to `.agents/skills/security-audit/SKILL.md`.
- `/deploy` or `/devops` routes to `.agents/skills/devops-deploy/SKILL.md`.
- `/docs` or `/research` routes to `.agents/skills/docs-research/SKILL.md`.
- `/refactor` routes to `.agents/skills/refactor/SKILL.md`.
- `/test` routes to `.agents/skills/testing/SKILL.md`.
- `/use <skill1> <skill2>` loads and combines named skills.
- `/mode <mode-name>` loads `.agents/modes/<mode-name>.md` and keeps it active for the session.

If native slash commands are not supported, still treat those user messages as workflow commands.
