Apply infrastructure changes after explicit user review and approval.

> **This command makes real changes to cloud infrastructure. Never run without first running `/infra-plan` and receiving user confirmation.**

1. Read `.claude/config.json`. Confirm:
   - `config.infrastructure.cloud_provider`
   - `config.infrastructure.deployment_strategy`
   - `config.project_identity.environment`
2. **Confirm with the user** before proceeding:
   - Show the current environment (e.g. `staging`, `production`)
   - Ask: "Have you reviewed the plan output from `/infra-plan`? Confirm you want to apply these changes."
   - Do not proceed until the user explicitly confirms.
3. Navigate to `config.infrastructure.iac_directory` and run the apply command:
   - Terraform → `terraform apply tfplan` (uses the saved plan file — no `--auto-approve`)
   - Pulumi → `pulumi up --yes`
   - CDK → `cdk deploy`
   - Other → ask the user for the correct command
4. Monitor apply output. If any resource fails, halt immediately and report the error in full.
5. On success, update `.claude/memories/infrastructure-state.md` with the new service states and deployment timestamp.
6. Confirm deployed service endpoints are reachable before declaring success.
