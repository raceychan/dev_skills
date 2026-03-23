# Spec Modes

Use this guide to emphasize the right sections for different feature types.

Instruction files mentioned below are always project-local, resolved from `{project_root}/docs/agent/instructions/`.

## Frontend-heavy feature

Emphasize:
- Current user flow
- Component boundaries
- State management
- Loading / empty / error states
- Accessibility
- Analytics / instrumentation
- Browser performance and bundle impact

Usually read:
- `common.md`
- `frontend.md`
- `testing.md`
- `api.md` if frontend depends on contract changes

## Backend-heavy feature

Emphasize:
- Handler / service / domain boundaries
- Validation and business rules
- Error handling
- Concurrency / idempotency / transactions
- Persistence and data consistency
- Observability
- Rollout safety

Usually read:
- `common.md`
- `backend.md`
- `testing.md`
- `data.md` if schema changes are involved
- `api.md` if contracts change
- `rollout.md` if operational risk is non-trivial

## Full-stack feature

Emphasize:
- End-to-end control flow
- Contract alignment between client and server
- Shared validation rules
- Data flow and error propagation across layers
- Incremental rollout and compatibility

Usually read:
- `common.md`
- `frontend.md`
- `backend.md`
- `api.md`
- `testing.md`
- plus `data.md` / `rollout.md` as needed

## API design / contract change

Emphasize:
- Request / response schema
- Validation and error model
- Compatibility strategy
- Consumer impact
- Versioning or migration path

Usually read:
- `common.md`
- `api.md`
- `backend.md`
- `testing.md`

## Data / migration feature

Emphasize:
- Schema and storage changes
- Backfill plan
- Dual-read / dual-write strategy if needed
- Data correctness verification
- Rollback complexity

Usually read:
- `common.md`
- `data.md`
- `backend.md`
- `testing.md`
- `rollout.md`

## Refactor / internal architecture change

Emphasize:
- Current pain or technical debt
- Existing module boundaries
- New abstractions or ownership boundaries
- Behavioral non-goals
- Risk of regressions
- Safe sequencing

Usually read:
- `common.md`
- whichever domain files match the touched layers
- `testing.md`
- `rollout.md` when deployment risk exists

## Short-form vs full-form

### Short-form
Use for small, low-risk changes. Keep:
- Summary
- Goals / non-goals
- Relevant existing code
- Proposed design
- Testing strategy
- Risks / edge cases

### Full-form
Use for cross-team, cross-layer, high-risk, or review-heavy work. Cover the complete template, especially:
- Current state
- Alternatives considered
- Security / performance / rollout
- Explicit assumptions and open questions
