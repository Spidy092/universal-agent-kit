---
name: database
description: Database schema design, migrations, query optimization, and data management. Use for database changes, performance issues, or schema updates.
---

# Database Skill

## When to Use

Use when designing schemas, writing migrations, optimizing queries, managing data, or fixing database issues.

## Goal Tracking

Before starting, define:
- **Database Goal**: What specific database change are we making?
- **Impact**: What data/code will be affected?
- **Rollback Plan**: How will we undo if needed?
- **Verification**: How will we know it worked?

## Inputs to Gather

- database type (SQL, NoSQL, etc.)
- current schema
- data volume
- query patterns
- performance requirements
- backup strategy

## Workflow

### Phase 1: Analysis (5 min)
- [ ] Understand current schema
- [ ] Identify what needs to change
- [ ] Check for dependencies
- [ ] Plan migration strategy

### Phase 2: Design (10 min)
- [ ] Design schema changes
- [ ] Plan data migration if needed
- [ ] Create rollback plan
- [ ] Test on sample data

### Phase 3: Implementation (15-30 min)
- [ ] Write migration script
- [ ] Add indexes if needed
- [ ] Update application code
- [ ] Add error handling

### Phase 4: Testing (10 min)
- [ ] Test migration on dev/staging
- [ ] Verify data integrity
- [ ] Test rollback procedure
- [ ] Performance test queries

### Phase 5: Deployment (5 min)
- [ ] Backup production data
- [ ] Run migration
- [ ] Verify success
- [ ] Monitor for issues

## Schema Design Checklist

### Tables/Collections
- [ ] Primary key defined
- [ ] Foreign keys defined
- [ ] Indexes added for common queries
- [ ] Data types appropriate
- [ ] NULL/NOT NULL constraints set
- [ ] Default values set

### Relationships
- [ ] One-to-one relationships clear
- [ ] One-to-many relationships clear
- [ ] Many-to-many relationships clear
- [ ] Cascade rules defined

### Performance
- [ ] Indexes for WHERE clauses
- [ ] Indexes for JOIN conditions
- [ ] Indexes for ORDER BY clauses
- [ ] Composite indexes for multi-column queries
- [ ] Covering indexes for frequent queries

### Data Integrity
- [ ] Constraints enforced
- [ ] Validation at database level
- [ ] Transaction boundaries clear
- [ ] Deadlock prevention

## Migration Best Practices

### Before Migration
- [ ] Backup data
- [ ] Test on staging
- [ ] Plan rollback
- [ ] Schedule maintenance window if needed

### During Migration
- [ ] Use transactions
- [ ] Log progress
- [ ] Handle errors gracefully
- [ ] Monitor performance

### After Migration
- [ ] Verify data integrity
- [ ] Run application tests
- [ ] Monitor performance
- [ ] Update documentation

## Query Optimization

### Index Usage
- [ ] Check if indexes are being used
- [ ] Add missing indexes
- [ ] Remove unused indexes
- [ ] Monitor index performance

### Query Analysis
- [ ] Use EXPLAIN/ANALYZE
- [ ] Check for full table scans
- [ ] Check for unnecessary joins
- [ ] Check for suboptimal query plans

### Common Issues
- N+1 queries
- Missing indexes
- Over-fetching data
- Inefficient joins
- Blocking queries

## Database Types

### SQL (PostgreSQL, MySQL)
- Structured schemas
- ACID compliance
- Complex queries
- Relationships

### NoSQL (MongoDB, Redis)
- Flexible schemas
- Horizontal scaling
- Eventual consistency
- Document/key-value

### NewSQL (CockroachDB, TiDB)
- SQL interface
- Horizontal scaling
- ACID compliance
- Distributed

## Output Format

## Database goal
## Current schema
## Proposed changes
## Migration plan
## Rollback plan
## Verification
## Risks
