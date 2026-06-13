---
name: database-migration
version: 1.0.0
description: Safe database migration planning, execution, and rollback. Use when schema changes, data migrations, or database operations are needed.
---

# Database Migration Skill

## When to Use

Use when adding/modifying tables, columns, indexes, constraints, running data migrations, changing ORM models, or planning rollback strategies.

## Inputs to Gather

- Database type (PostgreSQL, MySQL, SQLite, MongoDB)
- ORM/framework (Prisma, Sequelize, TypeORM, Django, Rails)
- Current schema state
- Target schema state
- Data volume affected
- Downtime tolerance
- Rollback requirement

## Workflow

1. Identify current schema and migration tool.
2. Plan migration in reversible steps.
3. Check for data loss risks (dropping columns, changing types).
4. Add backup step before destructive changes.
5. Write up migration with rollback script.
6. Test on staging/dev first.
7. Provide verification queries.
8. Document manual rollback steps if needed.

## Safety

Always ask before:
- Dropping columns/tables with data
- Changing column types that may truncate data
- Running migrations on production
- Modifying auth/permission tables

## Output

```md
## Current state
## Migration plan
## Migration code (up)
## Rollback code (down)
## Verification queries
## Risks
## Rollback procedure
```
