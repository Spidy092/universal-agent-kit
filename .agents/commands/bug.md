# /bug

Aliases: `/debug`

Skills: `debugging`

Use when the user reports a bug, error, exception, stacktrace, failing command, regression, flaky test, or logs.

Required behavior:
- Read `AGENTS.md` first.
- Load `.agents/skills/debugging/SKILL.md`.
- Reproduce or inspect the failure before editing when possible.
- Find the root cause, make the smallest safe fix, and verify it.
- Add `security-audit` if the bug touches auth, secrets, payments, webhooks, permissions, or user data.

Output format:
- Summary
- What I found
- Fix / Changes
- Files changed
- Commands to run
- Verification
- Risks / Edge cases
