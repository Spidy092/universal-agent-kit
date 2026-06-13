---
name: devops-deploy
description: Deployment, CI/CD, VPS, AWS, Docker, Nginx, PM2, SSL, logs, health checks, rollback, and operational readiness.
---

# DevOps Deploy Skill

## When to Use

Use when deploying apps, configuring VPS/AWS, fixing PM2/systemd/Nginx, setting SSL, writing CI/CD, changing Docker, handling logs/health checks, or planning rollback.

## Goal Tracking

Before starting, define:
- **Deployment Goal**: What specific deployment are we doing?
- **Environment**: What environment are we deploying to?
- **Rollback Plan**: How will we undo if needed?
- **Verification**: How will we know deployment succeeded?

## Inputs to Gather

- OS/server
- app stack
- process manager
- port
- domain
- reverse proxy
- env variables
- logs
- deployment target
- rollback path

## Workflow

### Phase 1: Pre-deployment (10 min)
- [ ] Identify current runtime and deployment path
- [ ] Check environment variables
- [ ] Check ports and firewall
- [ ] Check process manager: PM2, systemd, Docker
- [ ] Check reverse proxy and SSL
- [ ] Create rollback plan

### Phase 2: Deployment (15-30 min)
- [ ] Deploy code changes
- [ ] Update configurations
- [ ] Restart services
- [ ] Verify services running

### Phase 3: Post-deployment (10 min)
- [ ] Add health check
- [ ] Add log commands
- [ ] Monitor for errors
- [ ] Verify functionality

### Phase 4: Verification (5 min)
- [ ] Test endpoints
- [ ] Check logs
- [ ] Verify health checks
- [ ] Document deployment

## Deployment Checklist

### Pre-deployment
- [ ] Code reviewed and approved
- [ ] Tests passing
- [ ] Database migrations ready
- [ ] Environment variables set
- [ ] Rollback plan documented

### During deployment
- [ ] Backup current version
- [ ] Deploy in correct order
- [ ] Monitor for errors
- [ ] Keep rollback ready

### Post-deployment
- [ ] Health checks passing
- [ ] Logs clean
- [ ] Functionality verified
- [ ] Monitoring active

## Common Deployment Patterns

### PM2 Deployment
```bash
# Start/restart application
pm2 start ecosystem.config.js
pm2 restart app-name

# Check status
pm2 status
pm2 logs app-name
```

### Docker Deployment
```bash
# Build and run
docker-compose build
docker-compose up -d

# Check status
docker-compose ps
docker-compose logs -f
```

### Nginx Configuration
- Check SSL certificates
- Verify proxy settings
- Test configuration
- Reload Nginx

## Health Checks

### HTTP Health Check
```bash
curl -f http://localhost:3000/health || exit 1
```

### Process Check
```bash
pm2 status | grep -q "online" || exit 1
```

### Log Check
```bash
pm2 logs --lines 100 --nostream | grep -i "error" || echo "No errors"
```

## Rollback Procedures

### PM2 Rollback
```bash
# Stop current
pm2 stop app-name

# Start previous version
pm2 start ecosystem.config.js --env production
```

### Docker Rollback
```bash
# Stop current
docker-compose down

# Start previous version
docker-compose -f docker-compose.prev.yml up -d
```

## Safety

Ask before editing production env, running migrations, restarting critical services, deleting logs/data, or changing DNS.

## Output Format

## Current state
## Deployment/fix plan
## Commands
## Health check
## Logs to check
## Rollback
## Risks
