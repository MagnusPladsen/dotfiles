# Dotfiles Overview

Managed via bare git repo at `~/.dotfiles/`. Use the `dotfiles` alias for all git operations.

> **Auto-generated** — update this file whenever dotfiles are added, removed, or reorganized.

## Tracked Configs

### Shell & Editor

| File | Purpose |
|------|---------|
| `.zshrc` | Zsh config (Oh My Zsh + Powerlevel10k, aliases, plugins, shell integrations) |
| `.vimrc` | Vim configuration |
| `.tmux.conf` | tmux configuration |
| `.gitignore` | Dotfiles allowlist (bare repo pattern: `/*` + `!` exceptions) |
| `.gitmodules` | Git submodules |

### Window Management — `.config/aerospace/`

[AeroSpace](https://github.com/nikitabobko/AeroSpace) is an i3-like tiling window manager for macOS. It automatically tiles windows, manages workspaces, and provides vim-style keybindings for window/workspace navigation.

| File | Purpose |
|------|---------|
| `config.toml` | AeroSpace tiling WM config (keybindings, gaps, workspace-monitor assignments, floating rules) |
| `layouts.json` | Workspace layout presets for `aerospace-layout-manager` |
| `pip-move.sh` | Moves PiP windows to the focused workspace on workspace change |
| `run-aerospace-layout-manager.sh` | Applies all layout presets from `layouts.json` |

#### AeroSpace Keybindings

**Scripts (OS-level hotkeys)**

| Keybinding | Action |
|------------|--------|
| `alt-t` | Toggle floating popup terminal (Kitty) |
| `alt-c` | Toggle floating popup terminal running Claude Code (`claude --dangerously-skip-permissions`) |
| `alt-s` | Apply workspace layout presets from `layouts.json` |

**Window Focus & Movement (vim-style)**

| Keybinding | Action |
|------------|--------|
| `alt-h/j/k/l` | Focus window left/down/up/right |
| `alt-shift-h/j/k/l` | Move window left/down/up/right |
| `alt-shift-arrow` | Join window with container in direction |
| `alt-slash` | Toggle layout between horizontal and vertical tiles |
| `alt-shift-minus/equal` | Resize window smaller/larger |

**Workspaces**

| Keybinding | Action |
|------------|--------|
| `alt-1` to `alt-6` | Switch to workspace 1–6 |
| `alt-shift-1` to `alt-shift-6` | Move window to workspace 1–6 (focus follows) |
| `alt-tab` | Toggle between last two workspaces |
| `alt-shift-tab` | Move workspace to next monitor |

**Modes**

| Keybinding | Action |
|------------|--------|
| `alt-shift-;` | Enter service mode |
| `alt-shift-enter` | Enter apps mode |

*Service mode:* `esc` reload config, `r` reset layout, `f` toggle float/tile, `backspace` close all windows but current.
*Apps mode:* `alt-w` open WezTerm.

### Status Bar — `.config/sketchybar/`

| File | Purpose |
|------|---------|
| `sketchybarrc` | Main SketchyBar config |
| `colors.sh` / `icons.sh` | Theme colors and icon definitions |
| `items/*.sh` | Bar items: battery, clock, cpu, front_app, ram, spaces, volume, wifi |
| `plugins/*.sh` | Plugins: aerospace, battery, clock, cpu, front_app, icon_map, load_spaces, ram, space, space_windows, update_workspace_icons, volume, wifi |

### Window Borders — `.config/borders/`

| File | Purpose |
|------|---------|
| `bordersrc` | JankyBorders config for window decoration |

### Terminals

#### Ghostty — `.config/ghostty/`

| File | Purpose |
|------|---------|
| `config` | Ghostty terminal config |

#### Kitty — `.config/kitty/`

| File | Purpose |
|------|---------|
| `kitty.conf` | Kitty terminal config |
| `kitty.conf.bak` | Backup config |
| `monokai-pro-spectrum.conf` | Color theme |
| `sessions/default.conf` | Default session layout |

### Neovim — `.config/nvim/`

Tracked as a submodule (Lazy.nvim-based config).

### Lazygit — `.config/lazygit/`

| File | Purpose |
|------|---------|
| `config.yml` | Lazygit configuration |
| `state.yml` | Lazygit state |

### Zed — `.config/zed/`

| File | Purpose |
|------|---------|
| `settings.json` | Zed editor settings |
| `keymap.json` | Custom keybindings |
| `keymap_backup.json` | Keybinding backup |
| `tasks.json` | Zed task definitions |

### Text Expansion — `.config/espanso/`

| File | Purpose |
|------|---------|
| `config/default.yml` | Espanso global config |
| `match/base.yml` | Text expansion rules |

### Fuzzy Finder — `.config/television/`

| File | Purpose |
|------|---------|
| `config.toml` | Global tv config (keybindings, UI, shell integration triggers) |
| `cable/*.toml` | Channel definitions (60+ channels for files, git, docker, k8s, etc.) |

Key custom channels: `files`, `procs`, `dotfiles`, `git-worktrees`, `git-repos`, `zoxide`.

### Other Configs

| Path | Purpose |
|------|---------|
| `.config/fastfetch/config.jsonc` | Fastfetch system info display |
| `.config/fastfetch/logo.txt` | Custom ASCII logo |
| `.config/rift/config.toml` | Rift config |

## Scripts — `scripts/`

| Script | Purpose |
|--------|---------|
| `copy-project-env.sh` | Copies gitignored env/config files (`.env`, etc.) from one git project directory to another. Used by `setup-project.sh` to sync env files into worktrees. |
| `dev-env.sh` | Creates a tmux dev session with splits for a given project directory. Generic version of the project-specific dev scripts. |
| `festival-dev.sh` | Starts a tmux dev session preconfigured for the Abaris Festival project (`~/git/abaris-festival/`). |
| `fraktas-dev.sh` | Starts a tmux dev session preconfigured for the Fraktas project. |
| `game-mode.sh` | Quits all running apps except Finder and Steam. Used via the `game-mode` alias. |
| `install_aerospace.sh` | Installs AeroSpace tiling WM and `aerospace-layout-manager` via Homebrew. |
| `install_sketchybar.sh` | Installs SketchyBar and its dependencies (sf-symbols, jq, gh, etc.) via Homebrew. |
| `pip-move.sh` | Moves Picture-in-Picture windows (Firefox/Edge) to the currently focused workspace so PiP follows you when switching workspaces. Runs automatically on workspace change. |
| `popup-claude-op.sh` | Toggles a floating Kitty terminal popup running Claude Code with `--dangerously-skip-permissions`. Bound to `alt-c` in AeroSpace. |
| `popup-terminal.sh` | Toggles a floating Kitty terminal popup (800x500, translucent, blurred, centered). Bound to `alt-t` in AeroSpace. |
| `run-aerospace-layout-manager.sh` | Reads layout presets from `layouts.json` and applies them all via `aerospace-layout-manager`. Restores predefined window arrangements. Bound to `alt-s`. |
| `setup-project.sh` | Sets up a git worktree for development: copies env files from the main worktree, detects the package manager (bun/pnpm/yarn/npm), and installs dependencies. |
| `start-claude-code.sh` | Cron-triggered script that runs `claude "hello world"` and logs the output. Used by the `com.user.claude-code-morning.plist` LaunchAgent. |
| `tmux-lazygit.sh` | Opens lazygit in the current tmux pane's working directory. Used for tmux popup integration. |
| `worktrees.sh` | Git worktree helpers: `wt <name>` creates a worktree + branch, `wt-close <name>` removes it. Worktrees are created in a sibling `*-worktrees/` directory. |

## Aliases (from `.zshrc`)

| Alias | Expands to | Purpose |
|-------|-----------|---------|
| `cd` | `z` (zoxide) | Smart directory jumping with frecency ranking |
| `dotfiles` | `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME` | Git operations on the bare dotfiles repo |
| `ls` | `eza --color=always --icons=always --long --git ...` | Pretty file listing with icons and git status |
| `ll` | `eza -lah --icons=always --group-directories-first` | Detailed file listing |
| `tree` | `eza --tree --level=2` | Tree view (2 levels deep) |
| `sauce` | `source ~/.zshrc && echo '~/.zshrc reloaded'` | Reload shell config |
| `t` | `tmux` | Short tmux |
| `ta` | `tmux a` | Attach to tmux session |
| `macos` | `pkill AeroSpace sketchybar borders` | Restart window management stack |
| `tiles` | `open -a "AeroSpace" && run-aerospace-layout-manager.sh` | Launch tiling WM and apply layouts |
| `pattymode` | `pkill AeroSpace sketchybar && open -a "Google Chrome"` | Kill WM stack and open Chrome |
| `git-merge` | `git mergetool --tool=nvimdiff --no-prompt` | Open merge conflicts in Neovim diff |
| `bupgrade` | `brew upgrade` | Upgrade Homebrew packages |
| `claude-notes` | `cd <Obsidian Vault> && claude --dangerously-skip-permissions` | Claude Code in the personal Obsidian vault |
| `claude-op` | `claude --dangerously-skip-permissions` | Claude Code without permission prompts |
| `game-mode` | `~/scripts/game-mode.sh` | Quit all apps except Finder and Steam |
| `repos` | `tv git-repos` | Browse git repos with Television fuzzy finder |

## Config Folders — `.config/`

| Folder | Purpose |
|--------|---------|
| `aerospace/` | AeroSpace tiling window manager — keybindings, gaps, workspace assignments, layout presets, and scripts for PiP/layout management |
| `sketchybar/` | SketchyBar status bar — bar items (battery, clock, cpu, spaces, wifi, etc.), plugins, colors, and icons |
| `borders/` | JankyBorders — window border decoration config |
| `ghostty/` | Ghostty terminal emulator config |
| `kitty/` | Kitty terminal emulator — config, color theme (Monokai Pro Spectrum), session layouts |
| `nvim/` | Neovim config (Lazy.nvim-based, tracked as git submodule) |
| `lazygit/` | Lazygit TUI git client — config and state |
| `zed/` | Zed editor — settings, keybindings, and task definitions |
| `espanso/` | Espanso text expander — global config and text expansion rules |
| `television/` | Television (tv) fuzzy finder — global config, keybindings, shell integration, and 60+ channel definitions |
| `fastfetch/` | Fastfetch system info display — config and custom ASCII logo |
| `rift/` | Rift config |

## Other Tracked Files

| Path | Purpose |
|------|---------|
| `fzf-git.sh` | fzf + git integration |
| `LaunchAgents/com.user.claude-code-morning.plist` | Scheduled Claude Code launch agent |
