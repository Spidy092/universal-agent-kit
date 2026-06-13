# Antigravity Project Instructions

Read `AGENTS.md` first. Treat it as the project contract.

Support these in-agent workflow commands:
- `/bug` or `/debug`
- `/review`
- `/fix <task>`
- `/ui` or `/frontend`
- `/security`
- `/deploy` or `/devops`
- `/docs` or `/research`
- `/refactor`
- `/test`
- `/use <skill1> <skill2>`
- `/mode <mode-name>`
- `/help`

Route commands through `.agents/commands` and `.agents/skills`. Maintain active modes from `.agents/modes` for the session.

Before editing, give a short plan. After editing, verify with terminal commands, browser checks, or artifacts when possible.

Safety:
- Ask before destructive actions.
- Do not expose secrets, tokens, private keys, or `.env` contents.
- Do not delete files broadly, reset databases, or force-push without approval.
- Keep changes minimal and report files changed.
