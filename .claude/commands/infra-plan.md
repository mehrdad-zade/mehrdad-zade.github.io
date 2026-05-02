Generate an infrastructure execution plan for review before any changes are applied.

1. Read `.claude/config.json`. Confirm:
   - `config.infrastructure.cloud_provider`
   - `config.infrastructure.deployment_strategy`
   - `config.project_identity.environment`
2. Navigate to the IaC directory: `config.infrastructure.iac_directory` (default `./infra`).
3. Run the appropriate plan command:
   - Terraform → `terraform init -input=false && terraform plan -out=tfplan`
   - Pulumi → `pulumi preview`
   - CDK → `cdk diff`
   - Other → ask the user for the correct command
4. If `$ARGUMENTS` is provided, pass as additional flags.
5. Parse the plan output and produce a human-readable summary:
   - Resources to **add**
   - Resources to **change**
   - Resources to **destroy** (highlight in bold — requires explicit confirmation)
6. If the plan includes any destroys or replacements of data-bearing resources (databases, storage buckets), halt and require explicit user confirmation before any `apply` step.
7. Do NOT run apply. The plan is for review only. Apply requires the `/deploy-app` command and explicit user sign-off.
