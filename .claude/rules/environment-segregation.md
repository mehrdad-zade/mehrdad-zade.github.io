# Environment Segregation

**Focus**: Strict local vs. production separation using environment variables.

## Core Principle

Never hardcode environment-specific values. All environment-dependent config — URLs, connection strings, API keys, feature flags — must be loaded from environment variables. The current environment is declared in `config.json` under `project_identity.environment`.

## Environment-Specific Behavior

| Concern | Local / Development | Production |
|---------|--------------------|-----------:|
| Services | Mock services or local containers (docker-compose) | Managed cloud services as listed in `config.json > infrastructure > core_services` |
| Database | Local instance or container | Managed DB (RDS, Cloud SQL, etc.) |
| Auth | Dev credentials via `.env` | Secrets manager / IAM roles |
| Logging | Verbose / DEBUG allowed | INFO and above only (see security-and-logging rules) |

## Configuration Loading Rules

1. **No hardcoded URLs or hostnames** — use `process.env.API_URL`, `os.Getenv("API_URL")`, `os.environ["API_URL"]`, etc.
2. **No hardcoded localhost** — even `localhost:5432` must come from an env var.
3. **Dev-only tooling** (hot reload, debuggers, profilers) must be conditionally loaded and excluded from production build artifacts.
4. **`.env` files** are for local use only. Never commit them. Provide a `.env.example` with all required keys and dummy values.

## Validation Checklist

Before any code reaches staging or production:
- [ ] All URLs and endpoints sourced from environment variables
- [ ] No dev-only imports/packages in the production bundle
- [ ] `.env` and secrets files listed in `.gitignore`
- [ ] All required env vars documented in `.env.example` and `ReadMe.md`
