# Documentation Sync

**Focus**: Keeping project artifacts current with every structural or logic change.

## Trigger Condition

Any time you make a change that affects system design, APIs, data models, infrastructure, or developer setup, you must cross-reference and update the relevant documentation files before closing the task.

## File Responsibility Map

| File | Update when… |
|------|--------------|
| `Documents/Architecture.md` | New service added, component relationship changes, data flow changes, infra resource added, architectural pivot |
| `Documents/Requirements.md` | A listed requirement is fulfilled, a new constraint is discovered, acceptance criteria changes |
| `Documents/Sprints/` | A task is completed (move to Done), a blocker is encountered (log it), a new task is created |
| `ReadMe.md` | New dependency added, setup step changes, environment variable added, port or command changes |

## Version History (Architecture.md)

Significant architectural pivots must be logged in `Architecture.md` with:
- ISO timestamp
- Description of what changed
- Reason / driving constraint

## Enforcement

The `post-edit-sync.sh` hook will remind you after every source file edit. The reminder is advisory — the obligation is yours to act on it. If a change is purely cosmetic (typo fix, comment reword, formatting), documentation updates are not required.

## Sprint File Format

Each sprint file in `Sprints/` should use this structure:

```markdown
# Sprint N — [Goal Summary]

## In Progress
- [ ] Task description

## Completed
- [x] Task description

## Blocked
- [ ] Task description — **Blocker**: [description]
```
