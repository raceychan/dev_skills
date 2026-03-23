# Spec Template

Use this template as a starting point for `{project_root}/specs/{feature_name}_spec.md`.

```md
# {Feature Title}

Status: draft

## Summary
Short description of the feature and the intended outcome.

## Project Root
Resolved project root for this spec:
`{project_root}`

## Background / Motivation
Why this work exists now. Describe user pain, product need, or engineering driver.

## Goals
- Goal 1
- Goal 2

## Non-goals
- Non-goal 1
- Non-goal 2

## Requirement Facts
What the requester explicitly asked for.

## Codebase Findings
What was confirmed by reading the repository.

## Assumptions
What is inferred and still needs validation.

## Instruction Context Used
List the project-local instruction files that informed this spec.
- `{project_root}/docs/agent/instructions/common.md`
- `{project_root}/docs/agent/instructions/frontend.md`
- `{project_root}/docs/agent/instructions/backend.md`

## Scope
### In scope
- Item 1
- Item 2

### Out of scope
- Item 1
- Item 2

## Relevant Existing Code
- `path/to/file`: what it does today and why it matters
- `path/to/file`: likely change point or dependency

## Current State / Existing Behavior
Describe the current flow, constraints, and important implementation details.

## Proposed Design
Describe the target design at the right level of detail.

### Architecture / Control Flow
Explain the end-to-end flow and where logic should live.

### File / Module Changes
- Modify `path/to/file` to ...
- Add `path/to/new_file` to ...
- Extend `path/to/file` because ...

## Alternatives Considered
### Option A
Pros / cons.

### Option B
Pros / cons.

### Chosen Direction
Why it is preferred.

## Affected Areas and Change Boundaries
Describe which layers, modules, interfaces, and flows are expected to change, and which are intentionally left unchanged.

## Sequencing Considerations
Describe ordering constraints, dependency relationships, and rollout-sensitive sequencing at a design level. Do not turn this into an atomic task list.

## Data / Schema Implications
List model, DB, cache, storage, or migration changes.

## API / Contract Implications
Describe request/response changes, validation rules, error handling, and compatibility.

## Frontend Implications
Describe route, component, state, rendering, interaction, loading, empty, and error-state impact.

## Backend Implications
Describe handlers, services, domain logic, jobs, persistence, authorization, concurrency, and observability impact.

## Observability
Logs, metrics, traces, dashboards, and alerts to add or update.

## Security / Permissions / Abuse Cases
Authentication, authorization, data exposure, rate limits, misuse paths, and auditability.

## Performance Considerations
Latency, throughput, caching, N+1 risks, bundle size, query cost, and scaling concerns.

## Rollout / Migration / Backward Compatibility
Feature flagging, staged rollout, migrations, backfills, version compatibility, and rollback plan.

## Testing Strategy
- Unit tests
- Integration tests
- End-to-end tests
- Manual verification
- Regression coverage

## Risks / Edge Cases
- Risk:
- Edge case:
- Failure mode:

## Open Questions
- Question 1
- Question 2
```

## Usage Guidance

- Keep `Requirement Facts`, `Codebase Findings`, and `Assumptions` separate.
- Prefer naming concrete files, modules, endpoints, models, and state containers.
- Remove sections that are truly irrelevant, or mark them `N/A` when explicit absence is useful.
- For small changes, keep the spec short but still cover risks and testing.
- For larger changes, expand `Current State`, `Proposed Design`, `Alternatives Considered`, and `Rollout`.
- If the project contains project-specific instructions, make sure the spec reflects them and list which instruction files were used.
- Use project-local paths, not OpenClaw workspace-global paths, unless the workspace itself is the actual project.
- Keep the document at design level; do not degrade it into a checklist of micro-tasks.
