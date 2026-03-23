---
name: jira-issue-to-plan
description: Use a Jira issue key like AB-220, PROJ-123, or ENG-45 as the starting point for technical planning. Use when the user gives a Jira ticket number and wants the agent to fetch the issue from Jira, read its summary/description/acceptance details, and then begin planning work for the current project. Read the Jira issue first, then use it as requirement input for project-local spec or planning workflows.
metadata:
  {"openclaw":{"requires":{"env":["JIRA_BASE_URL","JIRA_EMAIL","JIRA_API_TOKEN"]},"primaryEnv":"JIRA_API_TOKEN"}}
---

# Jira Issue To Plan

Use a Jira issue as the requirement source for planning work.

## Purpose

Given a Jira issue key such as `AB-220`, fetch the issue from Jira and treat the issue contents as the planning input.

This skill is useful when the user wants to start from an issue number rather than pasting the whole requirement manually.

## Authentication Assumptions

Assume Jira access is provided through environment variables such as:
- `JIRA_BASE_URL`
- `JIRA_EMAIL`
- `JIRA_API_TOKEN`

For Jira Cloud, prefer the standard REST API with email + API token.

If these values are not available, stop and tell the user exactly which values are missing.

## API Strategy

Fetch the issue via Jira REST API. Prefer requesting only the fields needed for planning, such as:
- summary
- description
- issuetype
- status
- assignee
- reporter
- labels
- priority
- components
- acceptance criteria or custom fields if the instance uses them

If acceptance criteria is stored in a custom field and not discoverable from the initial response, note that explicitly rather than guessing.

## Planning Handoff Rule

After fetching the issue:
1. Summarize the Jira issue into requirement facts.
2. Preserve important original wording where it affects scope.
3. Use the Jira issue as the requirement source for planning.
4. Prefer routing into the existing planning flow:
   - `requirement-to-tech-spec` for spec only
   - `requirement-to-plan` for spec -> review -> todo workflow
   - `requirement-to-todo-list` only when the user already has an approved spec or explicitly wants tasks

## Project Root Rule

Treat `docs/agent/instructions/` and `specs/` as project-local.

Resolve the project root from the current execution directory:
1. git repository root
2. nearest ancestor that clearly looks like a project root
3. current working directory

Do not write specs or todos into the OpenClaw workspace unless that workspace is the actual project root.

## Output Expectations

When using this skill, the agent should usually:
- mention the Jira issue key used
- summarize the fetched issue into requirement facts
- identify any missing or ambiguous fields
- continue into the requested planning mode

If the user says only "use AB-220" without specifying mode, default to the planning workflow mindset:
- fetch Jira issue
- generate spec first
- pause for review before todo

## Failure Handling

If Jira returns not found, unauthorized, or missing-field responses:
- report the failure clearly
- do not invent requirement content
- ask only for the minimum missing Jira access or clarification needed

## Resources

- Jira field mapping notes: `references/jira-fields.md`
- Workflow routing notes: `references/routing.md`
