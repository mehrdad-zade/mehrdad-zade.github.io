Execute schema migrations for the SQL database layer.

> **Never run against production.** This command is restricted to `development` and `staging` environments.

1. Read `.claude/config.json`. Confirm:
   - `config.stack_specification.databases.sql` (target engine)
   - `config.stack_specification.databases.orm` (migration tool)
   - `config.project_identity.environment` — **halt if `production`**
2. Verify database connectivity before running any migration:
   - Attempt a simple connection check (e.g. `prisma db status`, `alembic current`, `go run ./cmd/dbcheck`)
   - If the connection fails, report the error and stop
3. Run the migration command appropriate to the ORM:
   - Prisma → `npx prisma migrate dev --name $ARGUMENTS`
   - Alembic → `alembic upgrade head`
   - golang-migrate → `migrate -path ./migrations -database $DATABASE_URL up`
   - Other → ask the user for the correct command
4. After migration completes, verify the schema is in parity with the ORM model definitions.
5. If any migration step fails, do not attempt a manual rollback without first showing the user the error and the available rollback options.
6. Update `.claude/memories/dependency-graph.md` with the new schema version.
