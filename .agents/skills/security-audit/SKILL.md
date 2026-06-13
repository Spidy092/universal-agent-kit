---
name: security-audit
description: Security review for auth, secrets, APIs, uploads, webhooks, permissions, dependencies, and deployment hardening.
---

# Security Audit Skill

## When to Use

Use when auth or permissions change, file uploads are added, webhook/payment endpoints are added, public API changes, secrets/config are touched, dependency changes, or security review is requested.

## Goal Tracking

Before starting, define:
- **Audit Goal**: What specific security aspect are we reviewing?
- **Trust Boundaries**: What are the security boundaries?
- **Done Criteria**: How will we know the audit is complete?

## Inputs to Gather

- trust boundary
- external input
- auth model
- sensitive data
- secrets/config
- dependencies changed
- logging/audit needs

## Workflow

### Phase 1: Threat Modeling (10 min)
- [ ] Identify assets, actors, and trust boundaries
- [ ] Map data flow
- [ ] Identify attack surfaces
- [ ] Prioritize risks

### Phase 2: Security Review (15-30 min)
- [ ] Review for auth bypass
- [ ] Review for IDOR
- [ ] Review for SQL/NoSQL injection
- [ ] Review for XSS
- [ ] Review for CSRF
- [ ] Review for SSRF
- [ ] Review for unsafe upload
- [ ] Review for exposed secrets
- [ ] Review for open CORS
- [ ] Review for missing rate limit
- [ ] Review for unsafe shell command
- [ ] Review for dependency/supply-chain risk

### Phase 3: Findings (10 min)
- [ ] Classify severity
- [ ] Document exploit scenarios
- [ ] Recommend mitigations
- [ ] Prioritize fixes

### Phase 4: Verification (5 min)
- [ ] Verify fixes work
- [ ] Test mitigations
- [ ] Document results

## Security Checklist

### Authentication
- [ ] Password hashing secure (bcrypt, argon2)
- [ ] Session management secure
- [ ] JWT implementation secure
- [ ] OAuth flow secure
- [ ] MFA implemented correctly

### Authorization
- [ ] Access controls enforced
- [ ] IDOR prevented
- [ ] Privilege escalation prevented
- [ ] Resource-based permissions

### Input Validation
- [ ] All input sanitized
- [ ] SQL injection prevented
- [ ] NoSQL injection prevented
- [ ] XSS prevented
- [ ] Command injection prevented

### Secrets Management
- [ ] No hardcoded secrets
- [ ] Environment variables used
- [ ] Secrets not logged
- [ ] Secrets not in version control

### Dependencies
- [ ] No known vulnerabilities
- [ ] Dependencies audited
- [ ] Lock files committed
- [ ] Supply chain risks assessed

### API Security
- [ ] Rate limiting implemented
- [ ] Input validation on all endpoints
- [ ] Error messages don't leak info
- [ ] CORS properly configured

## Common Vulnerabilities

### OWASP Top 10
1. Injection
2. Broken Authentication
3. Sensitive Data Exposure
4. XML External Entities
5. Broken Access Control
6. Security Misconfiguration
7. Cross-Site Scripting
8. Insecure Deserialization
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

## Severity Classification

- **Critical**: Immediate exploit risk, data breach potential
- **High**: Significant security risk, needs urgent fix
- **Medium**: Security weakness, should be fixed
- **Low**: Minor security improvement, nice to have

## Output Format

## Threat surface
## Critical/high findings
## Medium/low findings
## Mitigations
## Verification
## Residual risk
