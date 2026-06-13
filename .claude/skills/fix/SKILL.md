---
name: fix
description: Route implementation and repair tasks to RTK prompting plus auto-detected supporting skills.
---

Read `AGENTS.md` first, then use `.agents/commands/fix.md` and `.agents/skills/rtk-prompting/SKILL.md`.

Workflow:
- Treat the request text as the task.
- Add `debugging` for errors, logs, failing builds, or regressions.
- Add `security-audit` for auth, payment, webhook, token, secret, permission, or user data.
- Add `frontend-ui` for UI, mobile, responsive, design, CSS, or animation.
- Implement the smallest safe change and verify it.
