---
name: performance-optimization
version: 1.0.0
description: Performance profiling, bottleneck identification, and optimization for frontend, backend, and database. Use when response times, bundle sizes, or resource usage need improvement.
---

# Performance Optimization Skill

## When to Use

Use when pages are slow, API responses lag, bundle size is large, database queries are N+1, memory leaks exist, or Core Web Vitals fail.

## Inputs to Gather

- Performance metrics (response time, FPS, LCP, FID, CLS)
- Profiling data if available
- Target performance goals
- Current bottlenecks identified
- Infrastructure constraints

## Workflow

1. Measure before optimizing (no guessing).
2. Identify the bottleneck layer: network, server, database, rendering, bundle.
3. Profile with appropriate tools.
4. Apply targeted fix (not premature optimization).
5. Measure again to confirm improvement.
6. Check for regressions in other areas.

## Common Fixes

### Frontend
- Code splitting and lazy loading
- Image optimization (WebP, lazy, responsive)
- Bundle analysis and tree shaking
- Memoization of expensive computations
- Virtual scrolling for long lists

### Backend
- Query optimization (indexes, joins, eager loading)
- Caching strategy (Redis, CDN, HTTP cache)
- Connection pooling
- Async processing for heavy tasks
- Response compression

### Database
- Add missing indexes
- Fix N+1 queries
- Query plan analysis
- Connection pool tuning
- Read replicas for read-heavy loads

## Output

```md
## Measurement (before)
## Bottleneck identified
## Optimization applied
## Measurement (after)
## Code changes
## Trade-offs
## Remaining issues
```
