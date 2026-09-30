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
| `CLAUDE.md` | Claude Code instructions for the home directory (dotfile workflow, key paths, cmux/tv reference, behavior and response-formatting rules) |

### Window Management — `.config/aerospace/`

[AeroSpace](https://github.com/nikitabobko/AeroSpace) is an i3-like tiling window manager for macOS. It automatically tiles windows, manages workspaces, and provides vim-style keybindings for window/workspace navigation.

| File | Purpose |
|------|---------|
| `config.toml` | AeroSpace tiling WM config (keybindings, gaps, workspace-monitor assignments, floating rules) |
| `layouts.json` | App → workspace placement and root layout per workspace, read by `restore-workspaces.sh` |
| `pip-move.sh` | Moves PiP windows to the focused workspace on workspace change |

#### AeroSpace Keybindings

**Scripts (OS-level hotkeys)**

| Keybinding | Action |
|------------|--------|
| `alt-t` | Open a tiled Kitty terminal in `~` in the currently focused workspace |
| `alt-c` | Open a tiled Kitty terminal in `~` running `claude-op`; drops to a shell when Claude exits |
| `alt-s` | Restore app → workspace placement from `layouts.json` (`restore-workspaces.sh`) |

**Window Focus & Movement (vim-style)**

| Keybinding | Action |
|------------|--------|
| `alt-h/j/k/l` | Focus window left/down/up/right |
| `alt-shift-h/j/k/l` | Move window left/down/up/right |
| `alt-shift-arrow` | Join window with container in direction |
| `alt-slash` | Toggle layout between horizontal and vertical tiles |
| `alt-shift-minus/equal` | Resize window smaller/larger |
| `alt-w` | Close focused window |

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

*Service mode:* `esc` reload config, `r` reset layout, `f` toggle float/tile, `backspace` close all windows but current.

### Status Bar — `.config/sketchybar/`

"Vesper" theme (notch black): pure `#000` bar with no border, so the notch blends in; peach and mint accents, Martian Mono (`brew install --cask font-martian-mono`). 32pt on the built-in display so it ends exactly at the bottom of the notch (30pt elsewhere). Left: workspace numbers (the focused one is a peach pill), then the focused app and its window title. Right: `cpu` and `mem` meters, internet (Wi-Fi / ethernet / offline glyph), battery, time.

| File | Purpose |
|------|---------|
| `sketchybarrc` | Main SketchyBar config: bar look, defaults, item order |
| `colors.sh` | Theme colours (Vesper) |
| `items/*.sh` | Bar items in use: spaces, front_app (app + window title), cpu, ram, wifi, battery, clock. `separator` and `volume` are kept but not loaded |
| `plugins/*.sh` | Item scripts. `spaces_update.sh` redraws all workspace items per AeroSpace workspace change (2 `aerospace` calls). `front_app.sh` reads the focused window from AeroSpace on app switch, AeroSpace's `on-focus-changed` hook, and every 3s. `icon_map_fn.sh` is unused by this theme but kept: `~/.config/sketchybar.backup/` reads it |

**Other themes (full copies, not tracked):**

| Folder | Theme |
|--------|-------|
| `~/.config/sketchybar.prompt/` | "Prompt": text-only, GitHub Dark Dimmed, Fira Code |
| `~/.config/sketchybar.tokyo-night/` | Previous Tokyo Night Storm bar (also dotfiles tag `sketchybar-tokyo-night`) |

To switch, e.g. back to Tokyo Night:

```bash
mv ~/.config/sketchybar ~/.config/sketchybar.vesper && cp -R ~/.config/sketchybar.tokyo-night ~/.config/sketchybar && sketchybar --reload
```

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
| `new-kitty-window.sh` | Opens a plain tiled Kitty window in the currently focused AeroSpace workspace. `new-kitty-window.sh [directory] [command...]` (directory defaults to `~`; an optional command runs inside the new window). Uses `--single-instance` so the window lands on the current workspace instead of spawning a second Kitty instance. Bound to `alt-t` (plain shell) and `alt-c` (`claude-op`). |
| `pip-move.sh` | Moves Picture-in-Picture windows (Firefox/Edge) to the currently focused workspace so PiP follows you when switching workspaces. Runs automatically on workspace change. |
| `popup-kitty.sh` | Floating Kitty popup manager (800x500, translucent, blurred, centered). `popup-kitty.sh <name> [program...]` opens the window once and focuses it on repeat presses. Defaults to `~/ai-sandbox`; override with `POPUP_DIR`. Currently unbound - `alt-c` now opens a tiled window via `new-kitty-window.sh`. |
| `restore-workspaces.sh` | Moves each app in `~/.config/aerospace/layouts.json` to its workspace and sets each workspace's root layout. Reads all windows once, moves only misplaced ones, never changes focus, and launches listed apps that are not running. Bound to `alt-s`. |
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
| `tiles` | `open -a "AeroSpace" && ~/scripts/restore-workspaces.sh` | Launch tiling WM and apply layouts |
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
