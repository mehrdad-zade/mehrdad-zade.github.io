#!/bin/bash
# Fires after every Edit or Write tool call (PostToolUse).
# Detects structural file changes and injects a doc-sync reminder into context.
# Skips documentation files themselves to avoid recursive reminders.

INPUT=$(cat)

# Extract file path from tool input JSON
FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | cut -d'"' -f4)
if [ -z "$FILE" ]; then
    FILE=$(echo "$INPUT" | grep -o '"path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | cut -d'"' -f4)
fi

# Skip if no file detected or if the file IS a documentation file
if [ -z "$FILE" ]; then exit 0; fi
if echo "$FILE" | grep -qiE "(Architecture|Requirements|ReadMe|README|sprint|CLAUDE)\.md$"; then exit 0; fi

# Emit reminder only for source, config, and infrastructure files
if echo "$FILE" | grep -qE "\.(go|py|ts|tsx|js|jsx|rs|java|kt|rb|php|cs|sql|prisma|tf|tfvars|yaml|yml|json|toml|mod|sum|lock|dockerfile|sh)$"; then
    echo "[doc-sync] $FILE modified. If this is a structural change (new service, schema, API contract, infra resource, dependency), update the relevant file: Documents/Architecture.md | Documents/Requirements.md | Documents/Sprints/ | ReadMe.md"
fi

exit 0
