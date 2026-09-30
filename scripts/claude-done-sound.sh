#!/bin/bash
# Claude Code Stop hook: a novelty macOS voice sings a short line when Claude
# finishes a turn. Wired up in ~/.claude/settings.json (async, so it never
# blocks). Mute with: touch ~/.claude/mute-done-sound

[ -e "$HOME/.claude/mute-done-sound" ] && exit 0

lines=(
	"finally done"
	"it compiles, ship it"
	"another bug for tomorrow"
	"your turn, human"
	"I need a drink"
	"done, sadly"
)
voices=("Bad News" "Cellos" "Organ" "Bells" "Trinoids" "Superstar")

line=${lines[$((RANDOM % ${#lines[@]}))]}
voice=${voices[$((RANDOM % ${#voices[@]}))]}

say -v "$voice" "$line" >/dev/null 2>&1 &
exit 0
