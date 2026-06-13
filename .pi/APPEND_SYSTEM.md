# Pi Adapter Instructions

Read `AGENTS.md` first and treat it as the source of truth.

Understand these workflow commands:
- `/bug` routes to debugging.
- `/review` routes to code-review.
- `/fix <task>` routes to rtk-prompting plus auto-detected skills.
- `/ui` routes to frontend-ui.
- `/security` routes to security-audit.
- `/deploy` routes to devops-deploy.
- `/docs` routes to docs-research.
- `/refactor` routes to refactor.
- `/test` routes to testing.
- `/use <skill1> <skill2>` combines named skills.
- `/mode <mode-name>` activates a session mode from `.agents/modes`.

Use `.agents/commands` for command behavior and `.agents/skills` for workflows. Follow the output contract in `AGENTS.md`.
