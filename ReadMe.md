# claudeOS

A Claude Code project template with tiered LLM routing, agent specialization, automated sprint logging, and security guardrails — configurable from a single file.

---

## Setup (new project)

**One file to edit before anything else:** `.claude/config.json`

Replace every `YOUR_*` placeholder:

| Key | What to set |
|-----|-------------|
| `project_identity.name` | Your project name |
| `project_identity.environment` | `development`, `staging`, or `production` |
| `stack_specification.backends.primary` | Language, framework, and directory (e.g. Go / Gin / `./api`) |
| `stack_specification.backends.secondary` | Set `"enabled": false` if you have only one backend |
| `stack_specification.frontend` | Framework, styling library, directory |
| `stack_specification.databases` | SQL engine, NoSQL/cache, ORM |
| `infrastructure.cloud_provider` | AWS, GCP, Azure, etc. |
| `infrastructure.core_services` | Managed services your app uses (e.g. RDS, S3, CloudRun) |
| `infrastructure.third_party_services` | External APIs (e.g. Stripe, Twilio) |
| `infrastructure.deployment_strategy` | Terraform, Pulumi, CDK, etc. |
| `infrastructure.iac_directory` | Path to your IaC files (e.g. `./infra`) |
| `sprint_tracking.current_sprint` | Increment this when you start a new sprint |

Everything else in the template — agents, rules, commands, hooks — reads from this file automatically. You should not need to edit those files for standard projects.

---

## LLM Cost & Quality Tiers

Three tiers are pre-configured in `config.json`. Claude Code routes agents to the right tier automatically.

| Tier | Default Model | Used For |
|------|--------------|----------|
| `high` | Opus | Architecture decisions, security audits, complex migrations |
| `medium` | Sonnet | Feature work, APIs, frontend, database schemas |
| `low` | Haiku | Boilerplate, docs, linting, simple scripts |

To change a model, update the `model` field under `llm_orchestration.tiers.<tier>` in `config.json`, then update the `model:` frontmatter in the corresponding agent files under `.claude/agents/` to match. That is the only cross-file coupling.

---

## Slash Commands

Start any of these from the Claude Code prompt:

| Command | Use when |
|---------|----------|
| `/universal-runner` | Spin up all local services via docker-compose |
| `/test-suite` | Run all frontend and backend tests |
| `/audit-sec` | Scan dependencies and code for vulnerabilities before a PR |
| `/infra-plan` | Preview infrastructure changes (always run before deploy) |
| `/deploy-app` | Apply infrastructure changes (requires prior plan review) |
| `/db-migrate` | Run schema migrations (blocked in production) |

---

## Agents

Six specialist agents are available. Claude Code routes to them automatically; you can also invoke them explicitly.

| Agent | Escalate to when… |
|-------|-------------------|
| `architect-agent` | Task spans multiple services, or involves structural decisions |
| `frontend-expert` | UI components, state, styling, accessibility |
| `backend-specialist` | API endpoints, business logic, service layer |
| `db-architect` | Schema design, migrations, query optimization |
| `devops-specialist` | Docker, CI/CD, IaC, cloud provisioning |
| `security-auditor` | Auth flows, secrets, IAM, pre-PR compliance |

If an agent encounters a framework or service not in `config.json`, it will halt and report a `SPECIFICATION MISMATCH` rather than silently expanding your stack.

---

## Sprint Tracking

- Sprint files live in `Documents/Sprints/sprint-N.md`.
- The **Task Board** section (In Progress / Completed / Blocked) is yours to manage.
- The **Session Log** section is auto-written by Claude after every session that changes files.
- To start a new sprint: create `sprint-N.md` from the existing template and increment `sprint_tracking.current_sprint` in `config.json`.

---

## MCP Servers

Copy-paste ready server configs for GitHub, Postgres, Slack, AWS, Jira, Linear, and Datadog are in `.claude/mcp-servers.example.json`. To activate one, copy its block into the `mcpServers` object in `.claude/settings.json` and supply the required environment variables.

---

## Permissions & Safety

- **Allow list** (`.claude/settings.json → permissions.allow`): pre-loaded with safe read-only ops. Add stack-specific build/test commands here so Claude doesn't prompt for approval on every run (e.g. `"Bash(go test*)"`, `"Bash(npm run*)"`)
- **Deny list**: blocks destructive operations regardless of what Claude is asked to do.
- **`pre-bash-guard.sh`**: secondary layer that blocks dangerous shell patterns before they execute. Add patterns to the `BLOCKED` array for project-specific commands you never want run automatically.

---

## Project Documentation

Claude keeps these files current automatically when structural changes are made:

| File | Content |
|------|---------|
| `Documents/Architecture.md` | System design, component relationships, pivot log |
| `Documents/Requirements.md` | Functional requirements and fulfillment status |
| `ReadMe.md` | This file |

Update them manually when you make changes outside a Claude session (e.g. manual infra changes, design pivots decided in a meeting).
