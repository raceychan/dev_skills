# Artifact Conventions

Recommended outputs:
- `{project_root}/specs/{feature_name}_spec.md`
- `{project_root}/specs/{feature_name}_todo.md`

## Spec status markers

Recommended header lines in the spec:
- `Status: draft` for newly generated specs
- `Status: approved` after human review and acceptance

## Separation rule

Keep these concerns separate:
- Spec: design, scope, tradeoffs, boundaries, risks
- Todo: executable tasks, ordering, dependencies, acceptance criteria

## Hand-off rule

The todo artifact should reference the spec it was derived from when useful, for example:
- source spec path
- source spec revision date
- assumption that the spec is approved
