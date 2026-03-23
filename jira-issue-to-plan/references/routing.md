# Routing Notes

Use this skill to fetch the Jira issue first, then route into the right planning path.

## Default routing

If the user gives only an issue key and asks to start planning:
- fetch the Jira issue
- treat the issue as the requirement input
- produce a technical spec first
- pause for review
- generate a todo list only after approval

This matches the `requirement-to-plan` workflow.

## Other routing cases

### Spec only
If the user asks for a design doc, tech spec, or implementation proposal from a Jira ticket:
- fetch the ticket
- use the issue contents as input to the tech spec flow

### Todo only
If the user asks for tasks from a Jira ticket and already has an approved spec:
- fetch the ticket if needed for traceability
- prefer the approved spec as the source of task breakdown
- use the ticket only as additional context

## Source-of-truth rule

The Jira ticket is the initial requirement source.
Once a technical spec has been reviewed and approved, the approved spec becomes the source of truth for task breakdown.
