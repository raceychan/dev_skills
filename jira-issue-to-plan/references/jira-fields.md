# Jira Field Notes

Prefer these standard fields when fetching an issue for planning:
- `summary`
- `description`
- `issuetype`
- `status`
- `priority`
- `labels`
- `components`
- `assignee`
- `reporter`

## Description handling

Jira descriptions may be plain text, Atlassian Document Format (ADF), or custom-rendered content.

When the description is structured or nested:
- extract readable text conservatively
- preserve headings, bullets, and acceptance criteria when possible
- do not hallucinate missing body text

## Acceptance criteria

Acceptance criteria may appear in:
- the main description body
- a custom field
- linked subtasks or comments

Do not assume a custom-field name without evidence from the instance.
If acceptance criteria is not available, say so explicitly.

## Useful REST endpoint shape

Typical Jira Cloud pattern:
- `GET {JIRA_BASE_URL}/rest/api/3/issue/{ISSUE_KEY}?fields=summary,description,issuetype,status,priority,labels,components,assignee,reporter`

If richer planning context is needed, linked issues or comments can be fetched in a follow-up step, but avoid doing that by default.
