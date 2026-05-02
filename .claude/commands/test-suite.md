Run all tests across every enabled service in the project.

1. Read `.claude/config.json` to determine the active stack.
2. For each enabled backend in `config.stack_specification.backends`, derive and run the appropriate test command:
   - Go → `go test ./...` in the backend directory
   - Python → `python -m pytest` in the backend directory
   - Node/TypeScript → `npm test` or `yarn test` in the backend directory
   - Other → ask the user for the correct command before proceeding
3. Run frontend tests: navigate to `config.stack_specification.frontend.directory` and run `npm test` (or the framework equivalent).
4. If `$ARGUMENTS` is provided, pass it as additional flags to all test runners.
5. Collect results from all runners. Report:
   - Total pass / fail / skip counts per service
   - Full output for any failing test
   - A final PASS or FAIL verdict
6. If any tests fail, do not proceed with other tasks until the failures are investigated or the user explicitly acknowledges them.
