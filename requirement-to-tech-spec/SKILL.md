---
name: requirement-to-tech-spec
description: Turn a product or feature requirement into a repository-aware technical specification markdown file. Use when the user asks to write a tech spec, design doc, implementation proposal, technical solution, or scoped engineering design from a requirement and an existing codebase. First build a context collection plan from the requirement and repo structure, then read relevant code plus project-local docs/agent/instructions guidance from the current project root, and finally write project-local specs/{feature_name}_spec.md with concrete system design, affected areas, tradeoffs, compatibility, rollout, and testing scope. This skill produces a technical specification, not a task checklist.
---

# Requirement To Tech Spec

Convert a requirement into a repo-aware technical spec that is useful for engineering discussion and implementation planning.

## Core Rule

Treat `docs/agent/instructions/` and `specs/` as **project-local**, not global workspace-level directories.

Resolve them from the **current project root**, not from the OpenClaw workspace root.

## Spec vs Todo Boundary

This skill produces a **technical specification**, not a todo list.

Focus on:
- What should change
- Why the change is needed
- How the system should be designed or extended
- Which code areas are affected
- What constraints, risks, and tradeoffs matter
- What validation scope is required

Do **not** turn the output into:
- An atomic task list
- A checkbox checklist
- A step-by-step implementation recipe
- A developer handoff with micro-tasks

If the user explicitly asks for a task breakdown, implementation checklist, or execution todo list, use a separate todo-oriented skill or produce a separate todo artifact.

## Project Root Resolution

Before reading instructions or writing a spec, determine the project root from the current execution directory.

Use this priority order:

1. The repository root if inside a git repository
2. The nearest ancestor directory that clearly looks like a project root, such as one containing project manifests or top-level source directories
3. If no stronger signal exists, use the current working directory

Examples:

- If the current directory is `raceychan/workspace/myprojects/fullstack_template/apps/web`, the project root may be `raceychan/workspace/myprojects/fullstack_template`
- The correct instruction path is then `{project_root}/docs/agent/instructions/`
- The correct spec output path is `{project_root}/specs/{feature_name}_spec.md`

Do not default to the OpenClaw workspace root unless that workspace root is itself the actual project root being worked on.

## Workflow

1. Understand the requirement and restate it in implementation terms.
2. Determine the current project root.
3. Inspect the project structure from that root.
4. Produce a **Context Collection Plan** before deep reading code.
5. Read only the smallest useful set of code files needed to understand current behavior and likely change points.
6. Read instruction files under `{project_root}/docs/agent/instructions/` using the domain-selection rules below. Create the directory first if it does not exist.
7. Ensure `{project_root}/specs/` exists.
8. Write `{project_root}/specs/{feature_name}_spec.md`.

## Context Collection Plan

Before deep reads, explicitly identify:

- Requirement summary
- Resolved project root
- Affected product or technical areas
- Candidate directories/modules
- Priority files to read first
- Why each file matters
- Which files are intentionally deferred
- Likely affected layers: frontend, backend, API, data, testing, rollout

Use this plan to avoid reading the whole repository by default.

## Code Reading Rules

Prefer reading files in this order when applicable:

1. Entry points for the feature flow
2. Existing modules that would likely be extended
3. API handlers, controllers, services, or domain logic
4. UI screens, components, and state-management code
5. Schemas, models, migrations, or contracts
6. Tests that reveal current behavior
7. Config files that constrain implementation

Avoid broad repo sweeps unless the codebase is tiny or the requirement is architectural.

## Instruction Reading Rules

Instruction files are project-local and should be read from `{project_root}/docs/agent/instructions/`.

Always read:

- `{project_root}/docs/agent/instructions/common.md` if present

Then selectively read domain files that match the feature:

- `frontend.md` for UI, pages, components, client state, UX flows, loading/empty/error states, accessibility, or client performance
- `backend.md` for handlers, services, jobs, domain rules, permissions, concurrency, idempotency, transactions, logging, or observability
- `api.md` for request/response contracts, validation, error shapes, versioning, or external/internal API boundaries
- `data.md` for schema/model changes, persistence, migrations, backfills, consistency, retention, or compatibility
- `testing.md` for required test coverage, strategy, fixture style, integration boundaries, or regression expectations
- `rollout.md` for flags, migrations, staged release, monitoring, rollback, or operational risk

If the requirement clearly spans multiple layers, read multiple instruction files. Do not read every instruction file by default unless the feature truly spans all layers.

## Required Thinking Model

Keep these categories distinct inside the spec:

- **Requirement Facts**: what the user explicitly asked for
- **Codebase Findings**: what inspected files show today
- **Assumptions**: what is inferred but not yet proven

Do not blur assumptions into facts.

## Output Requirements

The generated spec should be implementation-oriented and usually include:

- Title
- Summary
- Background / motivation
- Goals
- Non-goals
- Requirement facts
- Codebase findings
- Assumptions
- Instruction context used
- Scope
- Relevant existing code
- Current state / existing behavior
- Proposed design
- Alternatives considered
- Affected areas and change boundaries
- Sequencing considerations
- Data / schema implications
- API / contract implications
- Frontend implications
- Backend implications
- Observability / logging / metrics
- Security / permissions / abuse cases
- Performance considerations
- Rollout / migration / backward compatibility
- Testing strategy
- Risks and edge cases
- Open questions

Adapt sections to the project. Omit irrelevant sections or mark them `N/A`.

## Quality Bar

- Prefer concrete repo paths, modules, and call flows over generic advice.
- Tie major design decisions to likely file or module changes.
- Mention tradeoffs, not just the chosen solution.
- Cover negative paths, not only the happy path.
- Describe implementation shape and sequencing constraints without decomposing the work into atomic tasks.
- If context is incomplete, state exactly what was inspected and what remains uncertain.
- Record the resolved project root in the spec when it helps avoid ambiguity.

## Resources

- Main spec template and guidance: `references/spec-template.md`
- Spec mode guidance by layer/type: `references/spec-modes.md`
- Boundary guidance: `references/spec-vs-todo.md`
