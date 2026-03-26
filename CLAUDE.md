# CLAUDE.md — Home Directory

## Dotfile Management

- **Bare git repo** at `~/.dotfiles/` — always use the `dotfiles` alias, NEVER regular `git`
- Workflow: `dotfiles add <file> && dotfiles commit -m "msg" && dotfiles push`
- `.gitignore` uses allowlist pattern: `/*` ignores everything, `!` exceptions whitelist tracked files
- **Tracked:** `.vimrc`, `.zshrc`, `.tmux.conf`, `.gitignore`, `scripts/`, `LaunchAgents/`, `fzf-git.sh/`, `.config/{nvim,espanso,sketchybar,ghostty,aerospace,borders,lazygit,zed,television}/`
- **Not tracked (intentional):** `.gitconfig` (machine-specific), `.p10k.zsh`
- **TODO:** `.config/kitty/` should be added to dotfiles tracking (currently missing)
- **README:** `~/README.md` documents all tracked configs, scripts, aliases, and keybindings

## Key Paths & Tools

| Path | Purpose |
|------|---------|
| `~/git/` | Repos (worktrees in `~/git/*-worktrees/`) |
| `~/scripts/` | Personal scripts |
| `~/.config/` | App configs (aerospace, sketchybar, kitty, ghostty, nvim, lazygit, zed, borders, espanso, television) |
| `~/.claude/skills/` | Claude Code skills |
| `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault` | Personal Obsidian vault — use `claude-notes` alias |

Work Obsidian vault is in the same iCloud path under "Abaris" folder (has its own CLAUDE.md).

## Shell Environment

- **Shell:** Zsh + Oh My Zsh + Powerlevel10k
- **Key aliases:**
  - `dotfiles` — git for bare dotfiles repo
  - `sauce` — source `.zshrc`
  - `claude-op` / `claude-notes` — Claude for Obsidian vaults
  - `macos` — restart window management stack
  - `tiles` — launch tiling WM
  - `wt` / `wt-close` — git worktree helpers
- **CLI tools:** zoxide (cd), fzf + fd, eza (ls/ll/tree), bat, delta, thefuck, tv (television)

## Editors & Terminals

- **Default editor:** Zed — use `zed <file>` when opening files
- **Terminals:** cmux (primary), Kitty, Ghostty
- **Terminal editors:** Neovim (Lazy.nvim config), Vim

## cmux (Terminal Multiplexer)

**Always use `cmux` instead of `tmux`.** cmux is a socket-based terminal multiplexer with a CLI API.

### Key commands

| Command | What it does |
|---------|-------------|
| `cmux list-workspaces` | List all workspaces |
| `cmux current-workspace` | Get current workspace |
| `cmux new-workspace [--command <cmd>]` | Create new workspace (optionally run a command) |
| `cmux new-split <left\|right\|up\|down>` | Split current pane in a direction |
| `cmux new-pane [--direction <dir>]` | Create new pane |
| `cmux list-panes [--workspace <id>]` | List panes in workspace |
| `cmux send [--surface <id>] <text>` | Send text to a surface/pane |
| `cmux send-key [--surface <id>] <key>` | Send a keypress (e.g. Enter, Tab) |
| `cmux read-screen [--surface <id>]` | Read screen content from a pane |
| `cmux focus-pane --pane <id>` | Focus a specific pane |
| `cmux close-surface [--surface <id>]` | Close a surface/tab |
| `cmux rename-workspace <title>` | Rename current workspace |
| `cmux notify --title <text> [--body <text>]` | Send a notification |

### Refs format

Use short refs: `window:1/workspace:2/pane:3/surface:4` or UUIDs. Pass `--id-format both` to see both.

### Splitting workflow

```bash
# Split right and run a command in the new pane
cmux new-split right
cmux send --surface <new-surface-id> "cd ~/git/project && npm test"
cmux send-key --surface <new-surface-id> Enter
```

## Television (tv) — Fuzzy Finder

**tv** (television) is a fast, hackable TUI fuzzy finder. Config at `~/.config/television/`.

- **Shell integration:** `Ctrl-T` smart autocomplete (context-aware channel), `Ctrl-R` command history
- **Default channel:** `files` — alias `repos` opens `git-repos` channel
- **Config structure:** `config.toml` (global settings/keybindings/shell integration), `cable/*.toml` (channel definitions)

### Key channels & keybindings

| Channel | Purpose | Key bindings |
|---------|---------|-------------|
| `files` | Find files (fd) | Enter=bat, Ctrl-E=nvim, Ctrl-Up=parent dir |
| `procs` | Manage processes | Ctrl-K=kill(SIGKILL), F2=term(SIGTERM), Ctrl-S=stop, Ctrl-C=continue |
| `git-repos` | Browse repos | Enter=select |
| `git-worktrees` | Switch worktrees | Enter=cd, Ctrl-D=remove |
| `git-branch` | Switch branches | Enter=select |
| `git-diff` | Stage/restore files | Enter=select |
| `git-log` | Browse commits | Enter=select |
| `dotfiles` | Edit dotfiles | Enter=edit ($EDITOR) |
| `zoxide` | Directory history | Enter=cd, Ctrl-D=remove |
| `docker-*` | Docker resources | Enter=select |

### Global keybindings (all channels)

| Key | Action |
|-----|--------|
| Ctrl-T | Toggle remote control (channel switcher) |
| Ctrl-X | Toggle action picker |
| Ctrl-O | Toggle preview |
| Ctrl-Y | Copy to clipboard |
| Ctrl-S | Cycle sources |
| Ctrl-R | Reload source |
| Tab/Shift-Tab | Multi-select |

### Shell integration triggers

Commands auto-open relevant channels on `Ctrl-T`: `cd/ls/z` → dirs, `cat/vim/bat/cp/mv/rm` → files, `git checkout/branch/merge` → git-branch, `git add/restore` → git-diff, `nvim/code` → git-repos.

### Editing channels

Channel configs are TOML files in `~/.config/television/cable/`. Each has: `[metadata]`, `[source]`, `[preview]`, `[keybindings]`, and `[actions.*]` sections. Actions use `mode = "execute"` (replace tv) or `mode = "fork"` (return to tv after).

## Behavior Rules

- **Always ask before modifying `.zshrc`** — critical config, easy to break
- **Prefer bun over npm** as package manager
- **Use `dotfiles` alias** for any git operations on home directory configs (not `git`)
- **Use `claude-notes` alias** when working on the personal Obsidian vault
- **Never commit secrets/tokens** — extra caution with `.env`, API keys, credentials

## macOS Window Management

- **AeroSpace** (tiling WM) — `.config/aerospace/`
- **SketchyBar** (status bar) — `.config/sketchybar/`
- **Borders** (window decoration) — `.config/borders/`
- Restart all: `macos` alias · Launch tiling: `tiles` alias

## Development Context

- **Personal GitHub:** MagnusPladsen
- **Work:** dev.azure.com/fraktas, bitbucket.org/abarisconsulting
- **Languages:** TypeScript/JS, Python, Rust, C#
- **Git:** delta for diffs, worktree aliases (`wta`, `wtl`, `wtr`)
