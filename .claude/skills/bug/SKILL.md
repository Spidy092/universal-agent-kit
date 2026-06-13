---
name: bug
description: Route bug reports, failing commands, stacktraces, regressions, and logs to the universal debugging workflow.
---

Read `AGENTS.md` first, then use `.agents/commands/bug.md` and `.agents/skills/debugging/SKILL.md`.

Workflow:
- Inspect the error, logs, failing command, or reproduction path.
- Find root cause before editing.
- Make the smallest safe fix.
- Add `security-audit` if auth, secrets, payments, webhooks, permissions, or user data are involved.
- Verify with exact commands and report results.
