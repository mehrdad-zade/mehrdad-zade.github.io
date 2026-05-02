# Engineering Persistent AI Context: A Framework for Agentic Autonomy in Polyglot Software Development

**Mehrdad Alemzadeh**

*Reference implementation: [github.com/GitHub/claudeOS](https://github.com/mehrdad-zade/claude-os/)*

---

## Abstract

Modern software engineering has shifted toward highly fragmented polyglot architectures, imposing significant cognitive load on developers and exposing a structural weakness in AI-assisted development tooling: **context drift**. Large Language Models (LLMs), while capable in isolation, lack awareness of a project's private, local ground truth — its specific languages, frameworks, deployment targets, and organizational conventions. This gap produces hallucinated defaults, broken builds, and repetitive priming overhead at the start of every AI session.

This paper proposes and details the **Systemic Context Injection (SCI) Framework**: a structured `.claude/` directory and `CLAUDE.md` file committed to any software repository, which together provide a machine-readable world model for AI agents. The framework comprises seven components: a declarative configuration engine (`config.json`), specialized sub-agent personas with model-tier assignments (`agents/`), slash command runbooks (`commands/`), persistent long-term memory (`memories/`), behavioral guardrails (`rules/`), lifecycle shell hooks (`hooks/`), and a permission and MCP configuration layer (`settings.json`). Together, these solve the **cold start problem**, eliminate prompt overhead, and deliver measurable gains in token efficiency, response latency, and error rate. A reference implementation is publicly available at the link above.

**Keywords**: large language models, agentic AI, context injection, Claude Code, polyglot development, prompt engineering, AI orchestration, software engineering

---

## 1. Introduction

### 1.1 The Polyglot Developer and Contextual Overload

Contemporary applications routinely span a React or Vue.js frontend, a Go or Rust microservice backend, Python data pipelines, Terraform infrastructure-as-code (IaC), and Docker orchestration — all within a single repository. The developer is expected to maintain simultaneous mastery of each layer.

The cognitive bottleneck is no longer syntactic recall but **contextual orchestration**: knowing which tool, version, convention, and deployment target applies to which layer at any given moment. As complexity scales, human working memory becomes the rate-limiting factor.

AI coding assistants offer a compelling solution in principle. In practice, they introduce a new class of failure mode: the generalist model operating without local context.

### 1.2 The Semantic Gap: Why Generalist LLMs Fail in Specialized Environments

LLMs are trained on vast corpora of public data, making them powerful generalists. They can write syntactically correct code in dozens of languages and generate boilerplate at speed. What they cannot do — absent explicit context — is reason about a project's private environment.

Consider a concrete failure: a developer asks an AI to "add a background job for email sending." A generalist model may suggest Celery (Python), when the project uses BullMQ (Node.js), connects to a Redis instance named in a project-specific environment variable, and requires all background jobs to conform to a specific retry-and-dead-letter-queue pattern from an internal architecture decision record. The AI produces code that is syntactically correct but architecturally wrong.

This is the **semantic gap**: the distance between the model's generic training-time knowledge and a project's runtime ground truth. Common manifestations include:

- Suggesting package managers (e.g., `npm`) in projects that enforce an alternative (e.g., `pnpm`)
- Generating IaC targeting the wrong cloud provider or deployment model
- Applying the conventions of one language service to a sibling service in a different language
- Recommending library versions incompatible with pinned dependencies

### 1.3 The Cold Start Problem

Every new AI session begins in a state of total amnesia. Developers compensate by spending the first several minutes of each session priming the AI: explaining the stack, pointing to the schema, warning about known bugs. This **prompt priming tax** is a measurable form of engineering waste. It interrupts flow state, scales poorly with team size, is not version-controlled, and is lost the moment the session ends.

### 1.4 Thesis

The missing layer in AI-assisted software development is not greater model capability but a **standardized, version-controlled project metadata layer**. By implementing a structured `.claude/` directory alongside a `CLAUDE.md` file at the repository root, teams can inject persistent, authoritative ground truth into every AI session — eliminating cold start overhead, reducing hallucinations, and enabling genuinely autonomous multi-step execution.

---

## 2. The Anatomy of Context Loss

### 2.1 Fragile Deployments: Ambiguous Infrastructure Context

In cloud-native environments, code cannot be evaluated independently of its deployment context. An otherwise correct Node.js function fails immediately if it assumes AWS Lambda's execution model while the project runs on Google Cloud Run. Without an explicit infrastructure anchor, AI-generated code carries hidden environmental assumptions.

These assumptions manifest as destructive suggestions: recommending libraries with native binary dependencies absent from the production Docker image, proposing IAM policy changes that conflict with existing least-privilege rules, or generating Terraform resources in the wrong provider region. Each failure is invisible until the build or deployment pipeline surfaces it — at which point the cost of diagnosis and correction is significantly higher than the cost of prevention.

### 2.2 Cross-Language Convention Errors

In polyglot monorepos, a Go backend, a Next.js frontend, and a Python worker service may coexist in the same repository. Without localized context, an AI may apply the conventions of one language domain to another: proposing a `__init__.py`-based folder structure inside a Go service, or generating `var`-style variable declarations in a codebase that enforces `const`-only JavaScript.

Framework-specific version semantics compound this problem. Go 1.22 introduced range-over-integer syntax; proposing it in a project pinned to Go 1.18 produces code that compiles on the developer's machine but fails in CI. The error is subtle and its root cause non-obvious without explicit version context in scope.

### 2.3 The Prompt Priming Tax

Beyond specific errors, there is a systemic overhead cost to context-free AI interaction. Developers habitually front-load each session with environmental exposition: "We use pnpm, not npm. The backend is Go 1.21. The database is Postgres accessed via `pgx`, not GORM. Never use `fmt.Println` in production — we use structured logging with `zap`."

This priming depends on the developer's recall of every relevant constraint. It is not version-controlled, not shared with collaborators, and lost at session end. At scale, it represents a meaningful fraction of total AI interaction time spent on meta-communication rather than problem-solving.

---

## 3. Framework Design: Systemic Context Injection

### 3.1 Design Principles

The SCI Framework is built on four principles:

1. **Declarative over imperative** — project constraints are stated as facts in structured files, not re-explained through natural language in each session.
2. **Single source of truth** — `config.json` is the authoritative record of the project's stack, infrastructure, and behavioral settings. All other framework components resolve values from it.
3. **Separation of concerns** — human-readable intent (`CLAUDE.md`, `rules/`) is separated from machine-executable capabilities (`commands/`, `hooks/`), which are separated from long-term state (`memories/`).
4. **Composable and portable** — the framework requires no external tooling beyond Claude Code and standard shell scripting. It is committed to version control alongside the project it describes.

### 3.2 Repository Layout

A project implementing the SCI Framework has the following structure:

```
.claude/
├── config.json           # Ground truth: stack, infra, agents, behavior
├── settings.json         # Permissions, lifecycle hooks, MCP servers
├── agents/               # Sub-agent persona definitions (Markdown + frontmatter)
│   ├── architect-agent.md
│   ├── backend-specialist.md
│   ├── db-architect.md
│   ├── devops-specialist.md
│   ├── frontend-expert.md
│   └── security-auditor.md
├── commands/             # Slash command runbooks (Markdown)
│   ├── audit-sec.md
│   ├── db-migrate.md
│   ├── deploy-app.md
│   ├── infra-plan.md
│   ├── test-suite.md
│   └── universal-runner.md
├── hooks/                # Shell scripts triggered by lifecycle events
│   ├── session-context.sh
│   ├── pre-bash-guard.sh
│   ├── post-edit-sync.sh
│   └── session-end.sh
├── memories/             # Persistent cross-session state (Markdown)
│   ├── dependency-graph.md
│   ├── infrastructure-state.md
│   └── naming-exceptions.md
└── rules/                # Behavioral guardrails (Markdown)
    ├── engineering-standards.md
    ├── environment-segregation.md
    ├── security-and-logging.md
    ├── documentation-sync.md
    ├── structure-and-naming.md
    └── sprint-logging.md

CLAUDE.md                 # Top-level instruction layer (repository root)
```

The `CLAUDE.md` file resides at the repository root and is automatically loaded by Claude Code as binding project instructions at the start of every session. It serves as the integration layer that references all components of the `.claude/` directory.

---

## 4. CLAUDE.md: The Session Instruction Layer

### 4.1 Purpose and Structure

`CLAUDE.md` is a Markdown file committed to the repository root. Claude Code reads it automatically at session initialization and treats its contents as instructions that override default model behavior. Its primary function is **orchestration**: it does not contain business logic directly, but imports and references every component of the `.claude/` directory, ensuring that rules, memories, and agent definitions are all active from the first message of every session.

A `CLAUDE.md` file typically contains:
- **Session initialization protocol** — the ordered sequence of steps Claude must perform at startup
- **Project identity** — name, version, environment, root directory (resolved from `config.json`)
- **Rule imports** — `@` directives that pull rule files into the active context
- **Memory imports** — `@` directives that load persistent state
- **Agent roster** — a reference table of available agents and their responsibilities
- **Command reference** — a table of slash commands and when to invoke them
- **Behavioral constraints** — naming conventions and security settings resolved from `config.json`

### 4.2 Session Initialization Protocol

`CLAUDE.md` specifies a mandatory startup sequence:

1. **Load `config.json`** — parse the full configuration object into working memory
2. **Resolve config tokens** — substitute all `{{config.path.to.value}}` references found in agent definitions, rule files, and the instruction layer itself
3. **Review memory imports** — read persistent state files to restore cross-session continuity
4. **Confirm state** — acknowledge the active project name, environment, and primary stack in a single sentence before addressing any user task

This protocol eliminates cold-start ambiguity. The AI begins each session with a fully resolved understanding of the project's identity and constraints.

### 4.3 Config Token Substitution

Throughout `CLAUDE.md`, agent files, and rule files, values are expressed as config references rather than hardcoded strings:

```markdown
- **Code naming**: `{{config.behavioral_settings.code_naming_convention}}`
- **Primary backend**: `{{config.stack_specification.backends.primary.language}}`
- **Cloud provider**: `{{config.infrastructure.cloud_provider}}`
```

At session start, Claude resolves these tokens by reading `config.json` and substituting each reference with its actual value. This means the same agent definition file accurately describes any project by updating a single file — `config.json`. No agent, rule, or command file requires modification when the stack changes.

---

## 5. The .claude/ Directory: The Operational Engine

### 5.1 config.json — Ground Truth Configuration

`config.json` is the canonical source of truth for the entire framework. All other components derive values from it. Its schema is organized into seven top-level namespaces:

| Namespace | Purpose |
|-----------|---------|
| `project_identity` | Name, version, environment, root directory |
| `llm_orchestration` | Model tier definitions with context caching and output token limits |
| `stack_specification` | Languages, frameworks, and directories for all services |
| `infrastructure` | Cloud provider, core services, third-party services, IaC tool |
| `agentic_capabilities` | Paths to agents, commands, memories, rules; active agent list; enforcement mode |
| `behavioral_settings` | Naming conventions, indentation, security enforcement flag |
| `sprint_tracking` | Current sprint number, sprint file directory, auto-logging flag |

The `llm_orchestration` namespace defines three model tiers:

| Tier | Model | Intent |
|------|-------|--------|
| `high` | `claude-opus-4-7` | Architecture, security-critical code, complex migrations |
| `medium` | `claude-sonnet-4-6` | Feature implementation, testing, integration work |
| `low` | `claude-haiku-4-5-20251001` | Boilerplate, linting, documentation, simple scripts |

Context caching is enabled on all three tiers. This reduces the per-session cost of loading the large `CLAUDE.md` context and its imports, which would otherwise be re-billed as input tokens on every prompt.

### 5.2 agents/ — Specialized Sub-Agent Personas

Each file in `agents/` defines a specialized AI persona using Markdown with YAML frontmatter:

```markdown
---
name: architect-agent
description: Lead Architect. Use for cross-service planning, structural decisions,
             resolving specification mismatches, and any task spanning multiple services.
model: claude-opus-4-7
---
```

The `model` field is hardcoded to match the agent's `default_model_tier` in `config.json`. Claude Code reads this field when routing tasks to sub-agents, ensuring the correct model tier is used without manual selection.

The body of each agent file defines:
- **Persona and mission** — what the agent is and what it is not permitted to attempt
- **Ground truth** — stack and infrastructure values injected via config tokens
- **Operational protocol** — a phased execution plan: Analysis & Routing → Execution with Guardrails → Memory Persistence
- **Constraint enforcement** — explicit halt conditions and escalation rules

The reference implementation ships six agents:

| Agent ID | Tier | Responsibility |
|----------|------|----------------|
| `architect-agent` | high | Cross-service orchestration, structural planning, final arbitration |
| `security-auditor` | high | Vulnerability scanning, secrets detection, auth review, IAM compliance |
| `frontend-expert` | medium | UI/UX implementation, component architecture, frontend testing |
| `backend-specialist` | medium | API design, business logic, backend testing |
| `db-architect` | medium | Schema design, migrations, query optimization |
| `devops-specialist` | medium | IaC, CI/CD, container orchestration, cloud provisioning |

**Escalation chain**: specialist agents handle domain-specific tasks independently. Tasks spanning multiple services or domains route to `architect-agent`. If the architect requires user authorization to proceed, it surfaces the decision explicitly rather than making the decision autonomously.

### 5.3 commands/ — Slash Command Runbooks

Files in `commands/` define Claude Code **slash commands** — user-invocable shortcuts that execute multi-step operational tasks. Each is a plain Markdown file containing a numbered, step-by-step runbook that Claude reads and executes when the command is invoked.

Commands are Markdown prose, not executable scripts or YAML/JSON tool definitions. They describe intent and steps in natural language, which Claude interprets and executes using its available tools. This makes them readable, modifiable, and extensible by any team member without scripting knowledge.

Example: the `/audit-sec` command, when invoked:

1. Reads `config.json` and confirms `security_checks_enabled` is `true`
2. Runs the appropriate dependency audit for each enabled backend (e.g., `govulncheck ./...` for Go, `npm audit` for Node.js, `pip-audit` for Python)
3. Runs Snyk if available (`snyk test`)
4. Greps all tracked files for hardcoded secret patterns (`api_key =`, `Bearer `, `-----BEGIN`, etc.), excluding `.env.example` and test fixtures
5. Reviews IaC files for overly permissive IAM rules or public-facing resources
6. Produces a structured report (Critical/High → block; Medium → warn; Low → note)
7. Updates `.claude/memories/` with any newly discovered vulnerabilities

Available commands in the reference implementation:

| Command | Purpose |
|---------|---------|
| `/universal-runner` | Start all services via `docker-compose` |
| `/test-suite` | Run frontend and backend test suites |
| `/audit-sec` | Dependency audit, secrets scan, IAM review |
| `/infra-plan` | Generate IaC execution plan for review before applying |
| `/deploy-app` | Apply infrastructure changes (requires prior `/infra-plan`) |
| `/db-migrate` | Execute schema migrations (non-production only) |

### 5.4 memories/ — Persistent Project Context

The `memories/` directory addresses the cold start problem at the semantic level. Where `config.json` captures what the stack currently is, memory files capture what has been **learned** over the course of development.

The reference implementation includes three default memory files:

- **`dependency-graph.md`** — tracks service-to-service API contracts and shared schema sync status. Updated by agents when new inter-service dependencies are established.
- **`infrastructure-state.md`** — records last known cloud service states, endpoints, and deployment timestamps. Updated by `devops-specialist` after each deployment.
- **`naming-exceptions.md`** — logs approved deviations from global naming conventions with justification and a `DO_NOT_RENAME` status flag.

Memory files are imported into `CLAUDE.md` via `@` directives, making their contents part of the active session context from the first message. Agents are instructed to update the relevant memory file before ending any session that includes a structural change, creating a feedback loop where the AI's accumulated project knowledge grows over time rather than resetting at session end.

### 5.5 rules/ — Behavioral Guardrails

Files in `rules/` define non-negotiable operational standards, imported into `CLAUDE.md` as binding instructions. Unlike agent files (which govern what a specific persona does), rule files govern what any agent does in any context.

The reference implementation includes six rule files:

| File | Focus |
|------|-------|
| `engineering-standards.md` | Modular architecture, DRY/SOLID, 30-line function ceiling, zero linting-warning policy |
| `environment-segregation.md` | No hardcoded URLs or credentials; env vars for all environment-specific config |
| `security-and-logging.md` | Input sanitization at all boundaries, auth enforcement on every endpoint, PII masking in logs |
| `documentation-sync.md` | Mandatory update of architecture, requirements, and sprint docs on any structural change |
| `structure-and-naming.md` | camelCase identifiers, kebab-case files, PascalCase components, UPPER_SNAKE_CASE constants, snake_case DB columns |
| `sprint-logging.md` | Automatic append of a structured session entry to the active sprint file after any file-modifying work |

Because rule files are committed to version control, they serve simultaneously as machine-enforced AI instructions and as the human-readable coding standards document for the team.

### 5.6 hooks/ — Lifecycle Automation

The `hooks/` directory contains shell scripts that Claude Code executes automatically at specific lifecycle events. Hooks are configured in `settings.json` and run outside the AI's reasoning loop — they are shell-level intercepts that inject data or block actions before or after the AI acts.

**`session-context.sh`** (trigger: `UserPromptSubmit`) — fires on every user prompt. Reads `config.json` to extract the project name, environment, current sprint number, and sprint log file path. It also reads live git state. The combined output is injected as a structured prefix into the prompt context:

```
[ctx] project=myapp | env=development | branch=main | dirty=3 | sprint-log=Documents/Sprints/sprint-1.md
```

Claude always knows the working tree state and the active sprint file without the developer having to state either.

**`pre-bash-guard.sh`** (trigger: `PreToolUse` on Bash) — fires before every shell command the AI attempts to run. Reads the proposed command from stdin as JSON and pattern-matches against a block list of destructive or irreversible operations:

```
terraform apply --auto-approve
terraform destroy
git push --force / git push -f
git reset --hard
rm -rf / and rm -rf ~
npx prisma migrate deploy
DROP TABLE / TRUNCATE TABLE / DELETE FROM
```

If a match is found, the hook exits with a non-zero code and returns a structured JSON block response (`{"decision":"block","reason":"..."}`), preventing the command from executing and surfacing the reason to the user.

**`post-edit-sync.sh`** (trigger: `PostToolUse` on Edit or Write) — fires after every file edit. Injects a reminder that structural changes may require updates to `Architecture.md`, `Requirements.md`, or `ReadMe.md`, enforcing the documentation-sync rule at the tool level.

**`session-end.sh`** (trigger: `Stop`) — fires when Claude finishes responding. Currently a reserved placeholder (exits 0); sprint logging and memory persistence are enforced through the loaded rule files rather than this hook, keeping concerns separated.

### 5.7 settings.json — Permissions, Security, and MCP Configuration

`settings.json` is the operational hub that wires the security and automation layers together. It contains three top-level sections:

**Permissions** — explicit allow and deny lists for Bash tool calls. The allow list covers read-only, non-destructive operations that run without a user confirmation prompt:

```json
"allow": [
  "Bash(git status)", "Bash(git diff*)", "Bash(git log*)",
  "Bash(ls*)", "Bash(find . *)", "Bash(grep *)", "Bash(cat *)"
]
```

The deny list hard-blocks commands that the `pre-bash-guard.sh` hook also catches, providing defense in depth. Two independent enforcement layers reduce the probability that a misconfiguration in either mechanism allows a destructive command through:

```json
"deny": [
  "Bash(terraform apply --auto-approve*)",
  "Bash(terraform destroy*)",
  "Bash(git push --force*)",
  "Bash(rm -rf*)",
  "Bash(git reset --hard*)"
]
```

**Hooks** — maps lifecycle event types to the scripts in `hooks/`:

```json
"UserPromptSubmit" → session-context.sh
"PreToolUse" [matcher: "Bash"] → pre-bash-guard.sh
"PostToolUse" [matcher: "Edit|Write"] → post-edit-sync.sh
"Stop" → session-end.sh
```

**MCP Servers** — the `mcpServers` block registers Model Context Protocol (MCP) server configurations. MCP servers extend the AI's capabilities with purpose-built tools: GitHub API access, database inspection, Slack messaging, cloud provider CLIs, and observability platforms. The reference implementation ships a companion file (`mcp-servers.example.json`) with ready-to-use templates for GitHub, PostgreSQL, Slack, AWS, Jira, Linear, and Datadog. All secrets must come from shell environment variables — never hardcoded values.

---

## 6. Mechanism of Action

### 6.1 The Plan-Act-Observe Loop

Agentic AI behavior follows a **Plan-Act-Observe** cycle. The SCI Framework enriches each phase with project-specific context:

- **Plan**: Before generating code, the agent consults `config.json` to determine the authorized stack. It resolves which language, framework, and tools apply to the task. This eliminates the exploratory phase where an AI asks clarifying questions about the environment.
- **Act**: The agent generates code or executes commands constrained by the resolved configuration. Tool selection follows command runbooks; code style follows rule files; model selection follows the tier assignment in the agent's frontmatter.
- **Observe**: After acting, the agent validates its output against the behavioral guardrails. If test and linting commands are defined, the agent can run them to self-audit. Errors are cross-referenced against the stack specification to identify the environmental root cause before the result is surfaced to the developer.

### 6.2 Specification Mismatch Protocol

A key safety mechanism is the **SPECIFICATION MISMATCH** protocol. Every agent is explicitly instructed: if a request requires a language, service, framework, or dependency not listed in `config.json`, halt immediately, state the mismatch explicitly, and route the decision to `architect-agent`. The architect then seeks explicit user authorization before proceeding.

This prevents a common failure mode where AI silently expands the project's technology surface — introducing a new dependency that was not reviewed for security, compatibility, or organizational standards. The protocol is encoded as a hard constraint in every agent's operational rules, not a soft suggestion:

> **SPECIFICATION MISMATCH**: If a request requires a language, service, framework, or dependency NOT listed in config.json, halt immediately. State the mismatch explicitly and seek user authorization before proceeding. Do not generate tech debt by silently expanding the stack.

### 6.3 Autonomous Self-Correction

A critical AI failure mode is the **hallucination of success** — the AI presents code it believes is correct that breaks the build. The SCI Framework addresses this through two complementary mechanisms:

1. **Pre-generation constraint filtering**: with the exact stack resolved at session start, the AI filters out suggestions that would fail before generating them. It does not suggest `go mod tidy` in a Node.js service or a package absent from the declared dependency manifest.

2. **Post-generation validation**: behavioral guardrails instruct the AI to run defined linting and test commands after code generation, checking its own output against the project's CI standards. Errors are cross-referenced against the stack specification to diagnose the environmental root cause rather than the surface symptom.

---

## 7. Economic and Performance Analysis

### 7.1 Token Efficiency

In an unaugmented session, a significant fraction of the context window is consumed by **discovery tokens**: the back-and-forth through which the agent learns about the environment. The SCI Framework eliminates the discovery phase. `config.json` and the `CLAUDE.md` imports provide a high-density, pre-structured reference that the AI reads once at session start. The developer's prompt then needs to convey only the **what** (the task) rather than the **how** (the environment).

For complex polyglot projects, prompt overhead reduction is estimated at 30–50% per session compared to context-blind interaction. Context caching (enabled on all model tiers in `config.json`) further reduces the per-token cost of subsequent prompts within the same session, as the large `CLAUDE.md` context is cached rather than re-billed on every turn.

### 7.2 Latency Reduction

Latency in AI-assisted development is best measured not as inference time but as **time to validated code** — the wall-clock duration from task statement to a result that passes the project's tests and linting rules. In context-blind sessions this is inflated by clarification rounds (the AI asks questions), correction rounds (the developer identifies environmental errors), and re-generation.

The SCI Framework drives toward **single-turn success**. With the environment fully specified at session start, the first generation attempt is constrained to be architecturally correct. Tasks that would previously require two to four clarification and correction iterations are resolved in one, reducing total developer-AI interaction time proportionally.

### 7.3 Error Rate Reduction

The framework's error mitigation operates at three independent levels:

1. **Configuration level** (prevented before generation): using the wrong package manager, cloud provider, or language toolchain is prevented by constraint propagation from `config.json` through all agent instructions.
2. **Generation level** (filtered during generation): behavioral guardrails covering naming conventions, architectural patterns, and security rules act as a real-time filter on code generation, preventing violations from appearing in the output.
3. **Execution level** (caught after generation): `pre-bash-guard.sh` blocks destructive commands; the `settings.json` deny list provides a second enforcement layer; post-generation linting and testing catch logical errors before the developer sees the result.

The compound effect of these three levels is a substantial reduction in broken-build scenarios relative to context-blind interaction, where no such filtering exists at any level.

---

## 8. Differentiating CLAUDE.md and .claude/

A common point of confusion is the relationship between the `CLAUDE.md` file and the `.claude/` directory. They are complementary, not redundant:

| Dimension | `CLAUDE.md` | `.claude/` directory |
|-----------|-------------|----------------------|
| Layer | Session instruction layer | Operational engine |
| Primary audience | Both human and AI | AI agents and shell automation |
| Content type | Orchestration, intent, `@imports` | JSON config, Markdown agents/commands/rules/memories, shell hooks |
| Mutability | Updated infrequently; governs session behavior | Updated frequently; tracks evolving project state |
| Format | Single Markdown file | Multi-file directory |
| Loaded by | Claude Code automatically at startup | Claude on demand; hooks executed by the shell runtime |
| Core function | **What** the project is and how the AI should behave | **How** the AI executes that behavior operationally |

`CLAUDE.md` is the entry point that makes the `.claude/` directory legible and actionable. Without it, `.claude/` components exist but have no session initialization order, no token resolution protocol, and no unified behavioral contract. Without `.claude/`, `CLAUDE.md` would need to contain all content inline, becoming unmaintainable at scale.

---

## 9. Implementation Guide

Adopting the SCI Framework requires three configuration steps, all in existing files:

**Step 1 — Edit `config.json`**: Replace all `YOUR_*` placeholder values with the actual values for your project. This is the only file that requires project-specific changes. All agent definitions, rule files, and command runbooks resolve their values from it automatically.

```json
{
  "project_identity": { "name": "my-api", "environment": "development" },
  "stack_specification": {
    "backends": {
      "primary": { "language": "Go", "framework": "Chi", "directory": "./backend" }
    },
    "frontend": { "framework": "Next.js", "styling": "Tailwind CSS", "directory": "./web" }
  },
  "infrastructure": { "cloud_provider": "AWS", "deployment_strategy": "Terraform" }
}
```

**Step 2 — Extend `rules/` as needed**: The default rule files cover standards applicable to most polyglot projects. Add project-specific constraints where appropriate — for example, documenting a banned library in `rules/security-and-logging.md`, or adding a project-specific architectural invariant to `rules/engineering-standards.md`.

**Step 3 — Configure `settings.json`**: Extend the `permissions.allow` list with the build and test commands specific to your stack (e.g., `Bash(go test ./...)`, `Bash(npm run build)`). Register any MCP server configurations in the `mcpServers` block using the templates in `mcp-servers.example.json`.

After these three steps, every Claude Code session in the repository begins with the full framework active: ground truth loaded, agents ready, hooks running, and guardrails enforced.

---

## 10. Discussion

The SCI Framework represents a shift in how AI tooling should be conceptualized in software development. The prevailing model treats AI assistants as stateless oracles — queried for advice, corrected by hand, and forgotten at session end. This model scales poorly and places the entire burden of context maintenance on the human developer.

The framework proposed here inverts this model: the repository becomes the source of truth, and the AI is a consumer of that truth rather than a guesser of it. Configuration replaces conversation; enforcement replaces hope.

Three limitations of the current framework warrant acknowledgment:

- **Token resolution is cognitive, not compiled**: the `{{config.x.y}}` substitution is performed by Claude at session start, not by a preprocessor. A misconfigured or deeply nested config value that fails silently during resolution could cause agents to operate on stale or empty values. Future tooling could provide compile-time token validation.
- **Memory files can become stale**: agents are instructed to update memory files after structural changes, but this relies on AI compliance within each session. Version control provides a recovery mechanism, but explicit memory freshness validation tooling would strengthen the guarantee.
- **MCP extends the attack surface**: registering MCP servers in `settings.json` grants the AI access to external systems. While secrets must come from environment variables and the permission model provides some containment, the combination of broad MCP access and autonomous agent behavior warrants careful scoping of permissions per server.

---

## 11. Conclusion

This paper has presented the Systemic Context Injection Framework: a practical, version-controlled approach to eliminating context drift in AI-assisted software development. By encoding a project's ground truth into a structured `.claude/` directory and surfacing it through a `CLAUDE.md` session instruction layer, development teams achieve the following:

- **Cold start elimination**: every session begins with the full stack, infrastructure, and behavioral context already loaded
- **Model tier optimization**: tasks are automatically routed to the appropriate model by capability and cost tier without manual selection
- **Guardrail enforcement**: coding standards, security policies, and naming conventions are applied at the agent level on every response
- **Destructive command prevention**: lifecycle hooks and the permission layer provide two independent enforcement layers against irreversible operations
- **Cross-session memory**: architectural decisions, known bugs, and naming exceptions persist across sessions in version-controlled Markdown files
- **Composable automation**: slash command runbooks make complex multi-step operational tasks (deployments, audits, migrations) reproducible and readable

The framework is intentionally minimal in its tooling requirements — Claude Code and standard POSIX shell scripts — and maximal in its scope of impact. A single `config.json` edit propagates through the entire agentic infrastructure: agent personas, behavioral guardrails, model tier assignments, and live session context.

The full reference implementation — all configuration files, agent definitions, command runbooks, rules, hooks, and `settings.json` — is available at [github.com/GitHub/claudeOS](https://github.com/GitHub/claudeOS).

---

## References

1. Anthropic. (2025). *Claude Code: Agentic Coding in Your Terminal*. Anthropic Documentation. https://docs.anthropic.com/en/docs/claude-code
2. Anthropic. (2025). *CLAUDE.md and Project Instructions*. Claude Code Documentation. https://docs.anthropic.com/en/docs/claude-code/memory
3. Anthropic. (2025). *Model Context Protocol (MCP)*. https://modelcontextprotocol.io
4. Anthropic. (2025). *Hooks: Lifecycle Automation in Claude Code*. Claude Code Documentation. https://docs.anthropic.com/en/docs/claude-code/hooks
5. Brown, T. B., Mann, B., Ryder, N., Subbiah, M., Kaplan, J., Dhariwal, P., ... & Amodei, D. (2020). Language Models are Few-Shot Learners. *Advances in Neural Information Processing Systems*, 33, 1877–1901.
6. Wei, J., Wang, X., Schuurmans, D., Bosma, M., Chi, E., Le, Q., & Zhou, D. (2022). Chain-of-Thought Prompting Elicits Reasoning in Large Language Models. *Advances in Neural Information Processing Systems*, 35, 24824–24837.
7. Yao, S., Zhao, J., Yu, D., Du, N., Shafran, I., Narasimhan, K., & Cao, Y. (2023). ReAct: Synergizing Reasoning and Acting in Language Models. *International Conference on Learning Representations (ICLR)*.
8. Park, J. S., O'Brien, J. C., Cai, C. J., Morris, M. R., Liang, P., & Bernstein, M. S. (2023). Generative Agents: Interactive Simulacra of Human Behavior. *Proceedings of the 36th Annual ACM Symposium on User Interface Software and Technology (UIST '23)*.
9. Shinn, N., Cassano, F., Labash, B., Gopinath, A., Narasimhan, K., & Yao, S. (2023). Reflexion: Language Agents with Verbal Reinforcement Learning. *Advances in Neural Information Processing Systems*, 36.
10. Weng, L. (2023). LLM-Powered Autonomous Agents. *Lil'Log*. https://lilianweng.github.io/posts/2023-06-23-agent/
