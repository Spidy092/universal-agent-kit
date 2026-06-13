---
name: performance
description: Performance profiling, optimization, memory leak detection, and load testing. Use when code is slow, uses too much memory, or needs to handle more load.
---

# Performance Skill

## When to Use

Use when code is slow, uses too much memory, needs to handle more load, or performance optimization is requested.

## Goal Tracking

Before starting, define:
- **Performance Goal**: What specific metric are we improving?
- **Baseline**: What is the current performance?
- **Target**: What performance do we need?
- **Constraints**: What are the limitations?

## Inputs to Gather

- current performance metrics
- performance bottlenecks
- user-facing impact
- system resources
- load patterns
- monitoring tools available

## Workflow

### Phase 1: Measurement (10 min)
- [ ] Identify what to measure (response time, memory, CPU, I/O)
- [ ] Set up measurement tools
- [ ] Establish baseline metrics
- [ ] Identify measurement methodology

### Phase 2: Profiling (15 min)
- [ ] Profile the code path
- [ ] Identify hot spots
- [ ] Check for memory leaks
- [ ] Check for unnecessary operations
- [ ] Check for blocking operations

### Phase 3: Analysis (10 min)
- [ ] Analyze profiling results
- [ ] Identify root causes of slowness
- [ ] Prioritize optimizations by impact
- [ ] Plan optimization strategy

### Phase 4: Optimization (15-30 min)
- [ ] Implement optimizations
- [ ] Verify optimizations work
- [ ] Check for regressions
- [ ] Document changes

### Phase 5: Verification (10 min)
- [ ] Measure performance after changes
- [ ] Compare to baseline
- [ ] Verify no functionality regressions
- [ ] Document results

## Common Performance Issues

### Frontend
- [ ] Large bundle sizes
- [ ] Unnecessary re-renders
- [ ] Missing lazy loading
- [ ] Unoptimized images
- [ ] Blocking scripts

### Backend
- [ ] N+1 database queries
- [ ] Missing database indexes
- [ ] Unnecessary database queries
- [ ] Blocking I/O operations
- [ ] Missing caching
- [ ] Inefficient algorithms

### Memory
- [ ] Memory leaks
- [ ] Large object retention
- [ ] Event listener leaks
- [ ] Closure issues
- [ ] Circular references

## Optimization Techniques

### Caching
- In-memory caching
- Redis/memcached
- CDN caching
- Browser caching
- Database query caching

### Database
- Add indexes
- Optimize queries
- Use connection pooling
- Implement pagination
- Use read replicas

### Code
- Reduce algorithm complexity
- Remove unnecessary operations
- Use async/await properly
- Implement lazy loading
- Use worker threads for CPU-intensive tasks

### Network
- Compress responses
- Use HTTP/2
- Implement CDN
- Reduce payload size
- Use connection pooling

## Measurement Tools

### Frontend
- Lighthouse
- Chrome DevTools
- WebPageTest
- Bundle analyzers

### Backend
- Node.js profiler
- Python cProfile
- Java JProfiler
- Go pprof

### Database
- EXPLAIN/ANALYZE
- Query logs
- Connection pool metrics

## Output Format

## Performance goal
## Baseline metrics
## Profiling results
## Optimizations applied
## Performance after
## Verification
## Risks/tradeoffs
