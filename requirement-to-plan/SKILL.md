---
name: requirement-to-plan
description: Orchestrate a two-stage planning workflow from a product or feature requirement. Use when the user wants a connected process that first generates a technical spec, pauses for human review, and then generates an execution-oriented todo list from the approved spec. This skill coordinates project-local planning artifacts from the current project root while keeping the technical spec and todo list as separate outputs.
---

# Requirement To Plan

Coordinate a planning workflow that links requirement analysis, technical design review, and execution planning.

## Core Rule

This skill is a **workflow/orchestration skill**.

It should not collapse the technical spec and todo list into one mixed document.

Instead, it should produce and manage two separate artifacts:
- `{project_root}/specs/{feature_name}_spec.md`
- `{project_root}/specs/{feature_name}_todo.md`

## Workflow Stages

### Stage 1: Draft Technical Spec
Use the technical-spec workflow to:
- analyze the requirement
- inspect the current project and relevant code
- read project-local `docs/agent/instructions/`
- write a technical spec draft

The technical spec is the **design source of truth**.

### Stage 2: Human Review Gate
After the spec draft is written, stop and request human review.

Do not generate the todo list yet unless the user explicitly asks to skip review.

The review outcome should be one of:
- approved
- approved with edits already applied
- revise spec first

### Stage 3: Generate Todo List From Approved Spec
Once the spec is approved, read the final spec and generate a todo list that reflects the approved design.

The todo list must be derived from the reviewed spec, not independently regenerated from the original PRD unless the user explicitly requests that.

## Project Root Resolution

Treat `docs/agent/instructions/` and `specs/` as project-local.

Resolve the project root using this priority:
1. repository root if inside git
2. nearest ancestor that clearly looks like a project root
3. current working directory

Do not default to the OpenClaw workspace root unless it is the actual project root.

## Operating Modes

### Mode A: Full workflow
Use when the user asks for a connected planning flow.

Output:
1. draft spec
2. pause for review
3. todo after approval

### Mode B: Review checkpoint only
Use when a spec already exists and the user wants help deciding whether it is ready for task breakdown.

Output:
- review summary
- approval / revision recommendation

### Mode C: Post-approval todo generation
Use when the spec is already approved and the user wants the todo list generated immediately.

Output:
- todo list derived from the approved spec

## Review Handling Rules

When pausing for review, clearly state:
- where the spec was written
- that the spec is draft or pending review
- what kind of approval signal is expected
- that todo generation will use the approved spec as its source of truth

Accepted continuation signals may include phrases like:
- "approved"
- "approved, continue"
- "use this revised spec and generate todo"
- "continue to todo"

If the user gives edits, update the spec first, then generate the todo list.

## Recommended Artifact Conventions

When helpful, include a simple status marker in the spec such as:
- `Status: draft`
- `Status: approved`

This is optional but recommended for reducing ambiguity in multi-turn planning flows.

## Boundaries

- Use `requirement-to-tech-spec` logic for the spec stage.
- Use `requirement-to-todo-list` logic for the todo stage.
- Keep design reasoning in the spec.
- Keep atomic tasks and acceptance criteria in the todo artifact.
- Do not let the todo artifact silently diverge from the approved spec.

## Resources

- Workflow guide: `references/workflow.md`
- Review state guide: `references/review-states.md`
- Artifact conventions: `references/artifacts.md`
