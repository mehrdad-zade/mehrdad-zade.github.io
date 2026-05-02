# Claude Code Master Configuration

> **NEW PROJECT SETUP**: The only file you need to edit is `.claude/config.json`.
> Replace every `YOUR_*` placeholder in that file before starting work.
> Everything else — agents, rules, commands, memory — resolves from config at session start.

---

## Session Initialization Protocol

At the start of **every session**, before any other action:

1. **Read config** — Load `.claude/config.json` in its entirety.
2. **Resolve tokens** — All `{{config.path.to.value}}` tokens throughout agents, rules, and commands are resolved using the loaded config. Substitute them mentally for the duration of the session.
3. **Memory is loaded below** — The three `@imports` in the Memory State section are already included in this context. Review them for continuity from prior sessions.
4. **Confirm state** — In one sentence, confirm the active project name, environment, and primary stack before proceeding.

---

## Project Identity

Resolved at session start from `config.project_identity`:

| Field | Config Key |
|-------|-----------|
| Name | `config.project_identity.name` |
| Version | `config.project_identity.version` |
| Environment | `config.project_identity.environment` |
| Root | `config.project_identity.root_directory` |

---

## Active Rules

@.claude/rules/engineering-standards.md
@.claude/rules/environment-segregation.md
@.claude/rules/security-and-logging.md
@.claude/rules/documentation-sync.md
@.claude/rules/structure-and-naming.md
@.claude/rules/sprint-logging.md

---

## Memory State

Loaded automatically below. Update the relevant file before ending any session that includes a structural change.

@.claude/memories/dependency-graph.md
@.claude/memories/infrastructure-state.md
@.claude/memories/naming-exceptions.md

---

## Agent Roster

All agents live in `.claude/agents/`. Each agent resolves its own stack context from `config.json`.
Escalation chain: specialist → `architect-agent` → user.

| Agent ID | Default Tier | Responsibility |
|----------|-------------|----------------|
| `architect-agent` | high | Cross-service orchestration, structural planning, final arbitration |
| `frontend-expert` | medium | UI/UX implementation, component architecture, frontend testing |
| `backend-specialist` | medium | API design, business logic, backend testing |
| `db-architect` | medium | Schema design, migrations, query optimization |
| `devops-specialist` | medium | IaC, CI/CD, container orchestration, cloud provisioning |
| `security-auditor` | high | Vulnerability scanning, secrets audit, compliance enforcement |

**Specification mismatch protocol**: If any agent receives a request requiring a language, service, or dependency not listed in `config.json`, it must halt, state a `SPECIFICATION MISMATCH` error, and route to `architect-agent`. The architect then seeks explicit user authorization before proceeding.

---

## Model Tiers

Tiers are resolved from `config.llm_orchestration.tiers` and applied in two ways:

1. **Agent frontmatter** — each agent file in `.claude/agents/` has a `model:` field hardcoded to the model that matches its `default_model_tier` in `config.json`. Claude Code reads this field when routing automatically.
2. **Explicit Agent tool calls** — when spawning a sub-agent manually, pass the model matching the agent's tier.

> When you change model names in `config.json`, update the corresponding agent frontmatter `model:` fields to keep them in sync. That is the only cross-file coupling in this setup.

| Tier | Model | Agent(s) | Intent |
|------|-------|----------|--------|
| `high` | `{{config.llm_orchestration.tiers.high.model}}` | architect-agent, security-auditor | Architecture, security-critical code, complex migrations |
| `medium` | `{{config.llm_orchestration.tiers.medium.model}}` | backend-specialist, frontend-expert, db-architect, devops-specialist | Feature implementation, testing, integration work |
| `low` | `{{config.llm_orchestration.tiers.low.model}}` | _(no dedicated agent — use directly for boilerplate tasks)_ | Boilerplate, linting, docs, simple scripts |

---

## Available Commands

Defined as slash commands in `.claude/commands/`. The skills directory has been replaced by this native Claude Code feature.

| Command | When to use |
|---------|-------------|
| `/universal-runner` | Start all local services via docker-compose |
| `/test-suite` | Run all frontend and backend tests |
| `/audit-sec` | Static analysis and dependency vulnerability scan (pre-PR) |
| `/infra-plan` | Generate IaC execution plan for review |
| `/deploy-app` | Apply infrastructure changes (requires prior `/infra-plan` review) |
| `/db-migrate` | Execute schema migrations (non-production only) |

---

## Project Documentation

Updated per the `documentation-sync` rule on every structural or logic change.

| File | Purpose |
|------|---------|
| `Documents/Architecture.md` | System design, component diagrams, pivot log with timestamps |
| `Documents/Requirements.md` | Functional and non-functional requirements, fulfillment status |
| `Documents/Sprints/` | Sprint planning, task tracking, blockers |
| `ReadMe.md` | Setup instructions, dependencies, developer onboarding |

---

## Hooks (Automated)

Defined in `.claude/settings.json`, executed by Claude Code automatically:

| Hook | Trigger | What it does |
|------|---------|--------------|
| `session-context.sh` | Every prompt | Injects project/env/branch/dirty-file count into context |
| `pre-bash-guard.sh` | Before every Bash call | Blocks dangerous command patterns (non-zero exit) |
| `post-edit-sync.sh` | After every Edit/Write | Injects doc-sync reminder for structural file changes |
| `session-end.sh` | When Claude stops | Reserved exit-0 placeholder; sprint logging and memory persistence enforced via loaded CLAUDE.md rules |

---

## MCP Servers

Configured in `mcpServers` block of `.claude/settings.json`. Currently empty — see `.claude/mcp-servers.example.json` for ready-to-use templates (GitHub, Postgres, Slack, AWS, Jira, Linear, Datadog).

---

## Behavioral Constraints

Resolved from `config.behavioral_settings`:

- **Code naming**: `{{config.behavioral_settings.code_naming_convention}}`
- **File naming**: `{{config.behavioral_settings.file_naming_convention}}`
- **Component naming**: `{{config.behavioral_settings.component_naming_convention}}`
- **Constants**: `{{config.behavioral_settings.constants_naming_convention}}`
- **Indentation**: `{{config.behavioral_settings.indentation}}`
- **Security checks enforced**: `{{config.behavioral_settings.security_checks_enabled}}`

Any deviation from the configured stack (`config.stack_specification`) or infrastructure (`config.infrastructure`) requires explicit user authorization.
