---
name: api-design
version: 1.0.0
description: REST/GraphQL API design, endpoint planning, contract definition, and versioning strategy. Use when building new APIs or refactoring existing ones.
---

# API Design Skill

## When to Use

Use when designing new endpoints, refactoring API structure, planning API versioning, defining request/response contracts, or reviewing API consistency.

## Inputs to Gather

- API style (REST, GraphQL, gRPC)
- Existing API patterns in codebase
- Authentication method
- Consumer types (frontend, mobile, third-party)
- Rate limiting needs
- Versioning strategy

## Workflow

1. Review existing API patterns and conventions.
2. Identify resource model and relationships.
3. Design endpoint structure following REST/GraphQL best practices.
4. Define request/response schemas with validation.
5. Plan error handling and status codes.
6. Add pagination, filtering, sorting patterns.
7. Document with OpenAPI/GraphQL schema.
8. Consider backward compatibility.

## Design Rules

- Use nouns for resources, HTTP verbs for actions
- Consistent naming (camelCase or snake_case, not mixed)
- Proper status codes (201 for creation, 204 for deletion)
- Pagination for list endpoints
- Meaningful error messages with error codes
- Rate limiting headers

## Output

```md
## API overview
## Endpoints
## Request/response schemas
## Authentication
## Error handling
## Versioning strategy
## OpenAPI/GraphQL schema
```
