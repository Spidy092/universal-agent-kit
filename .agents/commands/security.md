# /security

Aliases: none

Skills: `security-audit`

Use for auth, authorization, secrets, uploads, webhooks, payments, permissions, CORS, rate limits, validation, dependencies, or security review.

Required behavior:
- Read `AGENTS.md` first.
- Load `.agents/skills/security-audit/SKILL.md`.
- Avoid printing secrets, tokens, keys, or private configuration.
- Identify exploit path, impact, and smallest safe mitigation.
- Ask before weakening security controls or changing production-sensitive settings.

Output format:
- Summary
- What I found
- Fix / Changes
- Files changed
- Commands to run
- Verification
- Risks / Edge cases
