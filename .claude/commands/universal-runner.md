Start all project services for local development using docker-compose.

1. Read `.claude/config.json` and confirm the root directory (`config.project_identity.root_directory`).
2. Verify a `docker-compose.yml` or `docker-compose.yaml` file exists at the project root.
3. Run: `docker-compose up $ARGUMENTS`
   - If `$ARGUMENTS` contains `--build` or `build`, pass the `--build` flag to force a container rebuild.
   - Otherwise start without rebuilding.
4. Monitor startup output. If any service fails to start, report the service name and the last 20 lines of its logs.
5. Once all services are healthy, summarise the running services and their exposed ports.
