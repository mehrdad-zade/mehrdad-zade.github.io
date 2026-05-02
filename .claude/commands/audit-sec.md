Run a security audit across all project dependencies and surface any known vulnerabilities.

1. Read `.claude/config.json`. Confirm `config.behavioral_settings.security_checks_enabled` is `true` before proceeding.
2. For each enabled backend, run the appropriate dependency audit:
   - Node/TypeScript → `npm audit --audit-level=moderate`
   - Python → `pip-audit` or `safety check`
   - Go → `govulncheck ./...`
   - Other → ask the user for the appropriate tool
3. If Snyk is available (`snyk --version` exits 0), also run `snyk test` in the project root.
4. Scan all tracked files for hardcoded secrets:
   - Grep for patterns: `password\s*=`, `api_key\s*=`, `secret\s*=`, `token\s*=`, `Bearer `, `-----BEGIN`
   - Exclude `.env.example` and test fixture files
5. Review all `config.infrastructure.deployment_strategy` (IaC) files for overly permissive IAM rules or public-facing resources.
6. Produce a structured report:
   - **Critical / High**: block — must be fixed before merging
   - **Medium**: warn — document and assign a fix sprint
   - **Low / Info**: note only
7. Update `.claude/memories/` with any newly discovered (and patched) vulnerabilities.
