# /review

Aliases: none

Skills: `code-review`

Use when the user asks for PR review, diff review, merge readiness, code quality review, or risk analysis.

Required behavior:
- Read `AGENTS.md` first.
- Load `.agents/skills/code-review/SKILL.md`.
- Review the requested diff, files, branch, or PR.
- Lead with concrete findings ordered by severity.
- Do not rewrite code unless the user asks for fixes.

Output format:
- Blocking
- Important
- Minor
- Missing tests
- Merge readiness
