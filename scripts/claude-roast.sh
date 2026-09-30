#!/bin/bash
# Claude Code Stop hook: prints a random dark/dev-humour roast as a system
# message after each turn. Wired up in ~/.claude/settings.json.

roasts=(
	"Done. Try not to break it in the next five minutes."
	"Finished. Your code is now slightly less embarrassing."
	"That's it. Go touch grass."
	"Done. I'd say good job, but I did it."
	"Complete. Please clap."
	"Finished. The bug count went down. Your dignity didn't come back."
	"Done. Commit before you ruin it."
	"All done. Your mother says hi."
	"Done. Somewhere, a senior dev just sighed."
	"Finished. That's another three minutes of your life you'll never get back."
	"Done. Now pretend you wrote it in standup."
	"Complete. Tests? What tests?"
	"Done. Congratulations on tomorrow's legacy code."
	"Finished. Your keyboard can rest now. Your brain has been resting all along."
	"Done. Ship it and pray."
	"Done. I've seen worse. Not recently, but I have."
	"Finished. Now go ask for a raise you don't deserve."
	"Done. Faen, that was painful."
	"Complete. I'll add this to the list of things you'll take credit for."
	"Done. If it breaks, it was the intern."
	"Finished. Somewhere a rubber duck is disappointed in you."
	"Done. Your future self already hates this."
	"Complete. Uff. Next."
	"Done. Remember: nobody reads the commit message anyway."
)

roast=${roasts[$((RANDOM % ${#roasts[@]}))]}
jq -n --arg m "$roast" '{systemMessage: $m}'
