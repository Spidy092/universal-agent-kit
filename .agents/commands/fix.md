# /fix <task>

Aliases: none

Skills: `rtk-prompting`, plus auto-detected skills.

Use when the user wants an implementation or repair task done.

Required behavior:
- Read `AGENTS.md` first.
- Load `.agents/skills/rtk-prompting/SKILL.md`.
- Treat the text after `/fix` as the task.
- Add `debugging` for bug, error, stacktrace, failing build, exception, logs, or regression.
- Add `security-audit` for auth, payment, webhook, token, secret, permission, or user data.
- Add `frontend-ui` for UI, mobile, responsive, design, CSS, layout, or animation.
- Make the smallest safe code change and verify it.

Output format:
- Summary
- What I found
- Fix / Changes
- Files changed
- Commands to run
- Verification
- Risks / Edge cases
