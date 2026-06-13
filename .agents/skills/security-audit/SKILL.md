---
name: security-audit
description: Security review for auth, secrets, APIs, uploads, webhooks, permissions, dependencies, and deployment hardening.
---


# Security Audit Skill

## When to Use

Use when auth or permissions change, file uploads are added, webhook/payment endpoints are added, public API changes, secrets/config are touched, dependency changes, or security review is requested.

## Inputs to Gather

- trust boundary
- external input
- auth model
- sensitive data
- secrets/config
- dependencies changed
- logging/audit needs

## Workflow

1. Identify assets, actors, and trust boundaries.
2. Review for auth bypass, IDOR, SQL/NoSQL injection, XSS, CSRF, SSRF, unsafe upload, exposed secrets, open CORS, missing rate limit, unsafe shell command, and dependency/supply-chain risk.
3. Prefer concrete exploit scenarios.
4. Classify severity.
5. Recommend smallest sufficient mitigation.

## Output

```md
## Threat surface
## Critical/high findings
## Medium/low findings
## Mitigations
## Verification
## Residual risk
```
