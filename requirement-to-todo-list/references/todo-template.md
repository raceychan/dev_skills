# Todo Template

Use this as a starting point for `{project_root}/specs/{feature_name}_todo.md`.

```md
# {Feature Title} - Todo List

## Source Context
- Requirement / PRD:
- Technical spec:
- Technical spec status: approved
- Project root:

## Assumptions
- Assumption 1
- Assumption 2

## Task Groups

### Phase 1: Foundation
- [ ] Task
  - Why: reason
  - Acceptance: what proves it is done

### Phase 2: Core Implementation
- [ ] Task
  - Depends on:
  - Acceptance:

### Phase 3: Integration
- [ ] Task
  - Can run in parallel with:
  - Acceptance:

### Phase 4: Verification / Rollout
- [ ] Task
  - Acceptance:

## Dependencies / Blockers
- Blocker:
- Dependency:

## Parallelization Notes
- These tasks can happen concurrently:
- These tasks should remain sequential:

## Validation Checklist
- [ ] Unit coverage added or updated
- [ ] Integration paths verified
- [ ] Manual verification completed
- [ ] Rollout / migration validation completed if needed
```

## Guidance

- Keep tasks execution-oriented.
- Use the approved spec as the source of design truth when one exists.
- Include acceptance criteria for non-trivial tasks.
- Prefer grouped, readable tasks over excessive micro-tasking.
