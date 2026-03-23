# Review States

Use these simple states to reason about planning progress.

## Draft
The spec has been generated but has not been approved yet.

## In Review
The user is commenting on or revising the spec.

## Approved
The spec is accepted as the design source of truth for task breakdown.

## Revised After Review
The spec was updated in response to review feedback and is ready for approval or direct todo generation if the user says so.

## Rules
- Do not generate the todo list from a draft spec unless the user explicitly chooses to skip review.
- When the user provides edits, update the spec before deriving tasks.
- When approval is ambiguous, ask or wait rather than assuming.
