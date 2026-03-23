---
name: requirement-to-todo-list
description: Turn a product or feature requirement, approved technical spec, or implementation direction into an execution-oriented todo list. Use when the user asks for a task breakdown, implementation checklist, delivery plan, or atomic engineering tasks. Prefer using this after a tech spec already exists. Read relevant code and project-local docs/agent/instructions from the current project root as needed, then write a project-local todo artifact focused on executable steps, dependencies, validation, and acceptance criteria.
---

# Requirement To Todo List

Convert a requirement or technical spec into a concrete execution plan.

## Core Rule

This skill produces a **todo list / task breakdown**, not a technical spec.

Focus on:
- Concrete implementation tasks
- Suggested ordering
- Dependencies and blockers
- Parallelizable work
- Validation and acceptance criteria
- Handoff-ready, execution-oriented granularity

Do not spend most of the output re-explaining architecture tradeoffs that should already live in the spec.

## Project Root Resolution

Resolve output and project-local instructions from the current project root.

Use this priority order:
1. The repository root if inside a git repository
2. The nearest ancestor directory that clearly looks like a project root
3. Otherwise, the current working directory

## Inputs

Prefer one of these as source material:
- An existing technical spec
- A clarified requirement
- A PRD plus enough code/context to infer the implementation path

If a technical spec already exists, use it as the primary source of truth for task breakdown.

## Workflow

1. Understand the requirement or spec.
2. Determine the current project root.
3. Read the minimal relevant code and project-local instruction files needed to break the work into realistic tasks.
4. If a tech spec exists, align tasks to its chosen design rather than redesigning the solution.
5. Create a todo artifact in the project with executable tasks.

## Output Shape

The todo artifact should usually include:
- Title
- Source context
- Assumptions
- Task groups / phases
- Atomic tasks
- Dependencies
- Parallelization notes
- Validation / acceptance criteria
- Risks / blockers
- Optional owner suggestions or scope notes if useful

## Granularity Rules

Good tasks are:
- Concrete enough for a developer to pick up
- Small enough to estimate and review
- Large enough to avoid noisy micro-steps like "open file" or "run formatter"

Prefer tasks such as:
- "Add backend validation for X in the existing Y service"
- "Extend the account settings form to capture Z and handle API validation errors"
- "Add migration for new column and backfill existing records"

Avoid tasks such as:
- "Open `foo.ts`"
- "Write code"
- "Think about API"

## Output Location

Write to a project-local path such as:
- `{project_root}/specs/{feature_name}_todo.md`

If the project already has a `tasks/`, `plans/`, or similar execution-planning directory and the user prefers it, use that instead.

## Resources

- Todo template and guidance: `references/todo-template.md`
- Boundary guidance: `references/spec-vs-todo.md`
