#!/bin/bash

LOG_FILE="$HOME/logs/claude-code-cron.log"
MAX_LOG_SIZE=1048576  # 1MB

mkdir -p "$HOME/logs"

# Rotate log if it exceeds max size
if [ -f "$LOG_FILE" ] && [ "$(stat -f%z "$LOG_FILE" 2>/dev/null || echo 0)" -gt "$MAX_LOG_SIZE" ]; then
    mv "$LOG_FILE" "$LOG_FILE.old"
fi

command -v claude >/dev/null 2>&1 || { echo "$(date): claude not found" >>"$LOG_FILE"; exit 1; }

echo "$(date): Starting Claude Code session with 'hello world'" >>"$LOG_FILE"
claude "hello world" >>"$LOG_FILE" 2>&1
echo "$(date): Claude Code session initiated" >>"$LOG_FILE"
