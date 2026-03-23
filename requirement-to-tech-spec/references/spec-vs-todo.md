# Spec vs Todo

Use this guide to keep the technical spec separate from execution task breakdown.

## Technical Spec

A technical spec should answer:
- What problem is being solved
- What in the system is changing
- Why the proposed design is preferred
- Which modules, interfaces, and flows are affected
- What constraints, tradeoffs, and risks matter
- What testing and rollout scope are required

A technical spec should **not** primarily be:
- A checklist
- A sprint plan
- A list of atomic implementation tasks
- A file-by-file coding recipe

## Todo List

A todo list should answer:
- What concrete tasks need to be executed
- What order the tasks should happen in
- Which tasks can be parallelized
- What the acceptance signal is for each task
- What blockers or dependencies exist

## Practical Boundary

Good spec statement:
- "Backend contract changes should land before frontend adoption so the client can integrate against a stable response shape."

Too todo-like for a spec:
- "1. Modify backend controller. 2. Update service. 3. Regenerate client types. 4. Change frontend page. 5. Add tests."

Good spec statement:
- "The change should remain within the existing account settings flow and should not require a new global state container."

Too todo-like for a spec:
- "Create a new Zustand store in `stores/account.ts`."

## If the user wants both

Prefer two separate artifacts:
- `specs/{feature_name}_spec.md` for design
- A separate todo/task artifact for execution

Do not merge both into one document unless the user explicitly wants a combined format.
