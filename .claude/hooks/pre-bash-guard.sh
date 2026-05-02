#!/bin/bash
# Fires before every Bash tool call (PreToolUse).
# Reads the proposed command from stdin as JSON and blocks patterns that are
# destructive or irreversible without explicit user confirmation.
# Non-zero exit blocks the command from running.

INPUT=$(cat)

BLOCKED=(
    "terraform apply --auto-approve"
    "terraform destroy"
    "git push --force"
    "git push -f "
    "git reset --hard"
    "git checkout -- "
    "rm -rf /"
    "rm -rf ~"
    "npx prisma migrate deploy"
    "prisma migrate deploy"
    "DROP TABLE"
    "TRUNCATE TABLE"
    "DELETE FROM"
)

for PATTERN in "${BLOCKED[@]}"; do
    if echo "$INPUT" | grep -qi "$PATTERN"; then
        printf '{"decision":"block","reason":"Command matches blocked pattern: '\''%s'\''. Ask the user for explicit confirmation before running this."}\n' "$PATTERN"
        exit 2
    fi
done

exit 0
