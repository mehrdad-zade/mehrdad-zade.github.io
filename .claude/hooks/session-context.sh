#!/bin/bash
# Fires on every UserPromptSubmit.
# Injects project/env/branch/dirty-file count and active sprint file path into
# context so Claude always knows working tree state and where to log without asking.

CONFIG="$PWD/.claude/config.json"

PROJECT="unknown"
ENV="unknown"
SPRINT_FILE=""

if [ -f "$CONFIG" ]; then
    PROJECT=$(grep -o '"name"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG" | head -1 | cut -d'"' -f4)
    ENV=$(grep -o '"environment"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG" | head -1 | cut -d'"' -f4)
    SPRINT_NUM=$(grep -o '"current_sprint"[[:space:]]*:[[:space:]]*[0-9]*' "$CONFIG" | grep -o '[0-9]*$')
    SPRINT_DIR=$(grep -o '"sprint_directory"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG" | head -1 | cut -d'"' -f4)
    AUTO_LOG=$(grep -o '"auto_log"[[:space:]]*:[[:space:]]*[a-z]*' "$CONFIG" | head -1 | grep -o '[a-z]*$')
    if [ -n "$SPRINT_NUM" ] && [ -n "$SPRINT_DIR" ] && [ "$AUTO_LOG" != "false" ]; then
        SPRINT_FILE="$SPRINT_DIR/sprint-$SPRINT_NUM.md"
    fi
fi

BRANCH=$(git branch --show-current 2>/dev/null || echo "no-git")
DIRTY=$(git status --short 2>/dev/null | wc -l | tr -d ' ')

if [ -n "$SPRINT_FILE" ]; then
    echo "[ctx] project=$PROJECT | env=$ENV | branch=$BRANCH | dirty=$DIRTY | sprint-log=$SPRINT_FILE"
else
    echo "[ctx] project=$PROJECT | env=$ENV | branch=$BRANCH | dirty=$DIRTY"
fi
