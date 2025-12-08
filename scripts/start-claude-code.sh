#!/bin/bash

# Log file for tracking
LOG_FILE="$HOME/logs/claude-code-cron.log"
mkdir -p "$HOME/logs"

# Log the execution
echo "$(date): Starting Claude Code session with 'hello world'" >>"$LOG_FILE"

# Send "hello world" to Claude Code
claude "hello world" >>"$LOG_FILE" 2>&1

echo "$(date): Claude Code session initiated" >>"$LOG_FILE"
