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

| File | Purpose |
|------|---------|
| `config.toml` | AeroSpace tiling WM config |
| `layouts.json` | Workspace layout definitions |
| `pip-move.sh` | Picture-in-picture window mover |
| `run-aerospace-layout-manager.sh` | Layout manager launcher |
| `startup-workspace-setup.sh` | Workspace setup on boot |

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
| `copy-project-env.sh` | Copy project env files |
| `dev-env.sh` | General dev environment setup |
| `work-dev.sh` | Work project dev setup |
| `project-dev.sh` | project project dev setup |
| `install_aerospace.sh` | AeroSpace installer |
| `install_sketchybar.sh` | SketchyBar installer |
| `pip-move.sh` | PiP window mover |
| `popup-terminal.sh` | Popup terminal launcher |
| `run-aerospace-layout-manager.sh` | Layout manager runner |
| `setup-project.sh` | Project scaffolding |
| `start-claude-code.sh` | Claude Code launcher |
| `startup-workspace-setup.sh` | Boot workspace setup |
| `tmux-lazygit.sh` | Lazygit in tmux popup |
| `worktrees.sh` | Git worktree helpers |

## Other Tracked Files

| Path | Purpose |
|------|---------|
| `fzf-git.sh` | fzf + git integration |
| `LaunchAgents/com.user.claude-code-morning.plist` | Scheduled Claude Code launch agent |
