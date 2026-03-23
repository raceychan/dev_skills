# Workflow Guide

Use this skill to connect requirement -> spec -> review -> todo.

## Default Flow

1. Resolve project root.
2. Inspect relevant code and project-local instructions.
3. Generate `{feature_name}_spec.md`.
4. Mark or describe the spec as draft/pending review.
5. Pause and ask for human review.
6. After approval, read the final spec.
7. Generate `{feature_name}_todo.md`.

## Source of Truth Rule

- The requirement drives the initial spec.
- The reviewed spec drives the todo list.
- If the reviewed spec and original PRD diverge, prefer the reviewed spec unless the user says otherwise.

## Multi-turn Behavior

### First turn
Produce the spec and explicitly stop at the review gate.

### Review turn
If the user requests edits, revise the spec.
If the user approves, proceed to todo generation.

### Final planning turn
Generate the todo list from the latest approved spec.

## Optional Shortcuts

If the user explicitly says to skip the review gate, you may generate both artifacts in one pass, but still keep them as separate files.

This should be treated as an exception, not the default behavior.
