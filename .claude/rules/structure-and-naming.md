# Structure & Naming Conventions

**Focus**: Consistent project layout and identifier naming across all languages and frameworks.

## File & Folder Naming

| Target | Convention | Config Key |
|--------|-----------|------------|
| Source files | `{{config.behavioral_settings.file_naming_convention}}` | `behavioral_settings.file_naming_convention` |
| UI Components | `{{config.behavioral_settings.component_naming_convention}}` | `behavioral_settings.component_naming_convention` |
| Code identifiers | `{{config.behavioral_settings.code_naming_convention}}` | `behavioral_settings.code_naming_convention` |
| Constants | `{{config.behavioral_settings.constants_naming_convention}}` | `behavioral_settings.constants_naming_convention` |
| Database columns | `{{config.behavioral_settings.database_column_convention}}` | `behavioral_settings.database_column_convention` |

These conventions are non-negotiable. Approved deviations must be documented in `.claude/memories/naming-exceptions.md` with a reason and `DO_NOT_RENAME` status.

## Standard Folder Layout

```
{{config.project_identity.root_directory}}
├── {{config.stack_specification.backends.primary.directory}}/   # Primary backend
├── {{config.stack_specification.backends.secondary.directory}}/ # Secondary backend (if enabled)
├── {{config.stack_specification.frontend.directory}}/           # Frontend
├── .claude/              # Claude configuration (do not rename)
│   ├── agents/           # Sub-agent definitions
│   ├── commands/         # Slash command runbooks
│   ├── hooks/            # Lifecycle hook scripts
│   ├── memories/         # Persistent session state
│   └── rules/            # Enforced coding standards
├── Architecture.md
├── Requirements.md
├── ReadMe.md
└── Sprints/
```

Within each service directory, use this layout:

```
/src        — Application logic
/tests      — All test files
/config     — Configuration and environment loading
/public     — Static assets (frontend only)
```

## Enforcement

- Agents must validate file names and identifier casing before generating code.
- Any file that deviates from the conventions requires an explicit note in the PR and an entry in `naming-exceptions.md`.
