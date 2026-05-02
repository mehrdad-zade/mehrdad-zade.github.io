# Sprint Logging

**Focus**: Automatically appending a session entry to the active sprint file whenever Claude completes meaningful work.

## When to Log

Append one entry per response when your response included **any** of the following:
- Editing or writing files (source, config, infrastructure, documentation)
- Running shell commands with side effects
- Completing a user-requested task (feature, fix, refactor, config change)

**Skip** for read-only sessions: questions, explanations, or code reviews with no file edits.

## Where to Log

The active sprint file is:

```
{{config.sprint_tracking.sprint_directory}}/sprint-{{config.sprint_tracking.current_sprint}}.md
```

Read this file first. Then use **Edit** to replace the sentinel marker `<!-- end-of-sprint-log -->` with your entry followed by the sentinel again. This reliably appends without guessing at line numbers.

## Entry Format

```markdown
### {{YYYY-MM-DD}} — [verb-first title, 5–8 words]

**Objective**: [What the user asked for — one sentence.]

**Tasks Completed**:
- [past-tense action 1]
- [past-tense action 2]

**Definition of Done**:
- [verifiable outcome 1]
- [verifiable outcome 2]

**Files Changed**: `path/file1`, `path/file2`
**Agent**: [agent-id or "main session"] · `{{config.llm_orchestration.tiers.[tier].model}}`

---

<!-- end-of-sprint-log -->
```

## Silent Execution

The sprint entry IS the record. Never duplicate it in your response text.

- Do NOT announce the write ("I've logged this to sprint-1.md…")
- Do NOT print the sprint entry content in your response
- Do NOT narrate tool calls ("Updating Documents/Sprints/sprint-1.md")
- The Edit tool call for the sprint file is invisible infrastructure — treat it that way

## Response Mode by Session Type

| Session type | Response behaviour |
|---|---|
| Delivering work (file edits, commands) | Do the work silently. End with ≤ 2 sentences: what changed and what's next. Sprint entry is the full record. |
| Planning / design | Normal verbose response — no sprint entry needed unless files were changed. |
| Question / explanation | Normal response. Skip sprint entry. |

## Rules

1. Write the sprint entry **before ending your response** — never promise to log later.
2. One entry per response, regardless of how many tool calls were made.
3. Title is verb-first, past tense (e.g., "Fixed broken memory file references in agents").
4. Tasks describe what was done; DoD describes what is now verifiably true.
5. Keep each entry ≤ 20 lines.
6. If `## Session Log` section is absent from the sprint file, append it and the sentinel before writing the entry.
7. If `auto_log` is `false` in `config.sprint_tracking`, skip this rule entirely.
