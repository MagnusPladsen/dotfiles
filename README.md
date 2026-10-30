# Dotfiles Overview

Managed via bare git repo at `~/.dotfiles/`. Use the `dotfiles` alias for all git operations.

> **Auto-generated** — update this file whenever dotfiles are added, removed, or reorganized.

## New Mac Setup

Full bootstrap from a fresh macOS install or reformat. Run steps in order.

### Phase 1 — Foundation

#### 1. Xcode & Command Line Tools

```bash
xcode-select --install
```

Install Xcode from the App Store if you need iOS/macOS development.

#### 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### 3. Clone the bare repo

```bash
git clone --bare https://github.com/MagnusPladsen/dotfiles.git $HOME/.dotfiles
```

Set up the alias for this session (persists once `.zshrc` is checked out):

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

#### 4. Checkout dotfiles

```bash
dotfiles checkout
```

If this fails with "untracked working tree files would be overwritten", back up the conflicts and retry:

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
dotfiles checkout
```

Hide untracked files (so `dotfiles status` isn't noisy):

```bash
dotfiles config --local status.showUntrackedFiles no
```

#### 5. Initialize submodules

```bash
dotfiles submodule update --init --recursive
```

This clones:

| Path | Repo |
|------|------|
| `.config/nvim` | [MagnusPladsen/nvim](https://github.com/MagnusPladsen/nvim) |
| `.claude/mods` | [MagnusPladsen/claude-mods](https://github.com/MagnusPladsen/claude-mods) |
| `.claude/skills` | [MagnusPladsen/claude-skills](https://github.com/MagnusPladsen/claude-skills) |
| `.claude/rules` | [MagnusPladsen/claude-rules](https://github.com/MagnusPladsen/claude-rules) |

#### 6. Git identity

The global `user.email` defaults to your work address. Set the personal no-reply for the dotfiles repo and any personal repo:

```bash
dotfiles config --local user.email "93226629+MagnusPladsen@users.noreply.github.com"
dotfiles config --local user.name "Magnus Pladsen"
```

Do the same per-repo for anything under `github.com/MagnusPladsen/`.

### Phase 2 — Homebrew Packages & Apps

#### 7. Install Homebrew packages

```bash
brew bundle --file=~/Brewfile
```

The `Brewfile` covers all essential formulae, casks, and fonts. Review and uncomment optional dev tools at the bottom.

#### 8. Manually installed apps

These are not in Homebrew or require manual install (App Store, direct download, etc.):

| App | Source | Purpose |
|-----|--------|---------|
| **Chrome** | [google.com/chrome](https://google.com/chrome) | Browser |
| **Slack** | App Store or [slack.com](https://slack.com/downloads/mac) | Work chat |
| **Discord** | [discord.com](https://discord.com) | Chat |
| **Spotify** | [spotify.com](https://spotify.com/download) | Music |
| **Obsidian** | [obsidian.md](https://obsidian.md) | Notes (personal vault syncs via iCloud) |
| **Docker** | [docker.com](https://www.docker.com/products/docker-desktop/) | Containers |
| **Raycast** | [raycast.com](https://raycast.com) | Launcher (replaces Spotlight) |
| **Figma** | [figma.com](https://www.figma.com/downloads/) | Design |
| **Claude** | [claude.ai](https://claude.ai/download) | AI assistant (desktop app) |
| **Cursor** | [cursor.com](https://www.cursor.com/) | AI code editor |
| **Zed** | [zed.dev](https://zed.dev) | Editor |
| **Kitty** | [sw.kovidgoyal.net/kitty](https://sw.kovidgoyal.net/kitty/) | Terminal |
| **Rider** | [jetbrains.com](https://www.jetbrains.com/rider/) | .NET IDE |
| **DBeaver** | [dbeaver.io](https://dbeaver.io) | Database client |
| **Bruno** | [usebruno.com](https://www.usebruno.com) | API client |
| **Steam** | [store.steampowered.com](https://store.steampowered.com/about/) | Gaming |
| **Whisky** | [getwhisky.app](https://getwhisky.app) | Wine wrapper for macOS |
| **TinkerTool** | [bresink.com](https://www.bresink.com/osx/TinkerTool.html) | Hidden macOS preferences |
| **Zen** | [zen-browser.app](https://zen-browser.app) | Browser |
| **Kindle** | App Store | Reading |
| **Audible** | App Store | Audiobooks |

Optional / work-specific:

| App | Source | Purpose |
|-----|--------|---------|
| Android Studio | [developer.android.com](https://developer.android.com/studio) | Android dev (also needs Zulu JDK 17 from Brewfile) |
| Visual Studio Code | [code.visualstudio.com](https://code.visualstudio.com) | Editor (work projects) |
| Postman | [postman.com](https://www.postman.com/downloads/) | API client |
| UTM | [mac.getutm.app](https://mac.getutm.app) | Virtual machines |
| Microsoft Teams | Work portal | Work chat |
| Windows App | App Store | RDP |

### Phase 3 — Shell & Editor Setup

#### 9. Oh My Zsh + Powerlevel10k

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Restart your shell. Powerlevel10k runs its configuration wizard on first launch — or restore your backed-up `~/.p10k.zsh` if you have one (not tracked; machine-specific).

#### 10. fzf-git.sh

```bash
git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
```

#### 11. Rust / Cargo

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### 12. Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

#### 13. Node (via nvm)

```bash
brew install nvm
mkdir ~/.nvm
nvm install --lts
```

#### 14. Ghostty shader

The Ghostty config references a custom cursor smear shader. Clone or copy it:

```bash
mkdir -p ~/.config/ghostty/shaders
# Copy cursor_smear.glsl from your backup or source into ~/.config/ghostty/shaders/
```

#### 15. Neovim plugins

Open `nvim` — Lazy.nvim auto-installs all plugins on first launch.

### Phase 4 — macOS System Settings

These are not tracked in dotfiles. Run after each reformat.

#### 16. Appearance

```bash
# Dark mode (System Settings → Appearance → Dark)
# Or via:
# defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
```

Dark mode is set in System Settings → Appearance. The `defaults` command requires a re-login.

#### 17. Keyboard

```bash
# Fast key repeat (2 = fastest, default is 6)
defaults write NSGlobalDomain KeyRepeat -int 2

# Short initial delay before repeat (15 = short, default is 25)
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for accent characters (enables key repeat in all apps)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable smart quotes (breaks code pasting)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
```

**Keep enabled** (current settings): auto-capitalize, auto-period substitution.

#### 18. Trackpad & Mouse

```bash
# Disable natural scrolling (scroll direction matches finger movement for code)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
```

**Current settings:** tap-to-click off, two-finger right-click on, three-finger drag off. Adjust in System Settings → Trackpad if you want different.

#### 19. Finder

```bash
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Allow quitting Finder (cmd-Q)
defaults write com.apple.finder QuitMenuItem -bool true

# Default to Gallery view
defaults write com.apple.finder FXPreferredViewStyle -string "glyv"

# Restart Finder to apply
killall Finder
```

#### 20. Dock

```bash
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Don't show recent apps
defaults write com.apple.dock show-recents -bool false

# Icon size 71px
defaults write com.apple.dock tilesize -int 71

# No magnification
defaults write com.apple.dock magnification -bool false

# Remove all default Dock icons (optional — start clean)
defaults write com.apple.dock persistent-apps -array

# Add back just what you want (example: Proton Mail)
# Or just right-click → Remove from Dock for each unwanted icon after restart

# Apply
killall Dock
```

#### 21. Window management defaults (for AeroSpace)

```bash
# Mission Control: group windows by app
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

# Single Space across all displays (needs logout)
defaults write com.apple.spaces spans-displays -bool true

# Disable macOS drag-to-tile (conflicts with AeroSpace)
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false

# Drag any window from anywhere with ctrl-cmd
defaults write -g NSWindowShouldDragOnGesture -bool true

# Disable Stage Manager
# (Should be off by default; verify in System Settings → Desktop & Dock)
```

**Log out and back in** for `spans-displays` to take effect.

#### 22. Window corner radius

```bash
# Slightly rounded corners (6); macOS 26 default is 26, macOS 15 was 10
defaults write -g NSConvolutionOverride1 -float 6
```

Apps pick this up when relaunched. `0` is ignored (stays at 26). To revert:

```bash
defaults delete -g NSConvolutionOverride1
```

#### 23. Misc system preferences

```bash
# Don't create .DS_Store on network or USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Spring loading (drag file over folder to open it): enabled, 0.5s delay
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5
```

### Phase 5 — Window Management Stack

#### 24. Start the stack

```bash
open -a "AeroSpace"
brew services start sketchybar
brew services start borders
```

Restore workspace layouts:

```bash
~/scripts/restore-workspaces.sh
```

Verify: `alt-1` through `alt-6` switches workspaces, `alt-h/j/k/l` moves focus, SketchyBar visible at top.

### Phase 6 — Services & Agents

#### 25. LaunchAgents

```bash
ln -sf ~/LaunchAgents/com.user.claude-code-morning.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.claude-code-morning.plist
```

#### 26. Brew services

Confirm borders and sketchybar are running:

```bash
brew services list
```

### Phase 7 — Machine-Local Files (Not Tracked)

Create these manually — they're gitignored:

| File | Purpose |
|------|---------|
| `~/.p10k.zsh` | Powerlevel10k theme (generated by its wizard) |
| `~/.gitconfig` | Global git config (machine-specific user/email) |
| `~/.env` | Environment variables (API keys, tokens) |
| `~/.zshrc.local` | Machine-local shell helpers (work shortcuts like `azpr`) |
| `~/.config/espanso/match/priv.yml` | Private text expansions |
| `~/.config/ghostty/shaders/cursor_smear.glsl` | Ghostty cursor shader |
| `~/.config/kitty/sessions/` | Kitty session layouts |
| `~/.config/lazygit/state.yml` | Lazygit state (auto-created) |
| `scripts/work/` | Work-specific dev scripts |

### Phase 8 — Verification Checklist

```bash
# Shell
dotfiles status          # clean checkout, no untracked noise
fastfetch                # system info on terminal open
eza --version && bat --version && tv --version && fd --version
fzf --version && zoxide --version && rg --version && yazi --version
thefuck --version && lazygit --version && delta --version

# Editors
nvim --version           # Neovim + plugins loaded
vim --version

# Git
gh auth status           # GitHub CLI authenticated
git config user.email    # correct identity

# Window management
# AeroSpace running (alt-1..6, alt-h/j/k/l, alt-f, alt-slash)
# SketchyBar at top (workspaces, app title, cpu, mem, battery, clock)
# JankyBorders around focused window

# Keyboard
# Fast key repeat in any text field
# No accent popup on long-press
# No auto-correct

# Terminals
# Kitty: JetBrains Mono, Monokai Pro Spectrum
# Ghostty: JetBrains Mono, Monokai Pro Spectrum, translucent + blur + cursor smear shader

# Aliases
sauce                    # reload .zshrc
repos                    # tv git-repos fuzzy finder
tiles                    # restore AeroSpace layouts
```

---

## Tracked Configs

### Shell & Editor

| File | Purpose |
|------|---------|
| `.zshrc` | Zsh config (Oh My Zsh + Powerlevel10k, aliases, plugins, shell integrations). Sources the untracked, machine-local `~/.zshrc.local` for work-specific helpers when present |
| `.vimrc` | Vim configuration |
| `.tmux.conf` | tmux configuration |
| `.gitignore` | Dotfiles allowlist (bare repo pattern: `/*` + `!` exceptions) |
| `.gitmodules` | Git submodules (`.config/nvim`, `.claude/mods`, `.claude/skills`, `.claude/rules`) |
| `CLAUDE.md` | Claude Code instructions for the home directory (dotfile workflow, key paths, tv pointer, behavior and response-formatting rules) |
| `.claude/settings.json` | Claude Code user settings: hooks, plugins, status line, and custom `spinnerVerbs` and `spinnerTipsOverride` (dark/dev-humour spinner lines and tips), `companyAnnouncements` (random startup roast), a Stop hook for `claude-roast.sh`, the `Grumpy Norwegian Sysadmin` output style |
| `.claude/mods/` | Submodule ([claude-mods](https://github.com/MagnusPladsen/claude-mods), public). Claude Code mods (function-hook plugins), not loaded by default: add a mod folder to `env.CLAUDE_CODE_PLUGIN_DIRS` in `settings.json` to load it. `usage-warn` warns at every 10% of the 5-hour and 7-day usage windows from 50%, with a pace forecast, a status line and a notification plus chime at 90% (all configurable in `/config`); `filetree-collapsible` is a local fork of data-goblin's filetree pane with a collapse-to-strip button |
| `.claude/skills/` | Submodule ([claude-skills](https://github.com/MagnusPladsen/claude-skills), public). Magnus Pladsen kit global Claude Code skills: git and ticket workflow (`new-issue`, `commit`, `list-commits`, `create-pr`, `pr-description`, `changelog`, `workdayrecap`), engineering workflow (`planning-with-issues`, `debug`, `refactor`, `review`, `test`, `test-run`, `document`, `onboard`, `todo`), .NET (`add-migration`, `validate-architecture`), plus `frontend-design`, `dance` and `runapp` (build and open the Proton-ish app) and `highball-db-report` (report a Proton-ish game session to highball-db). Installer-managed TWG, Superset and synced skills share the directory but are gitignored in the submodule |
| `.claude/rules/` | Submodule ([claude-rules](https://github.com/MagnusPladsen/claude-rules), public). Magnus Pladsen kit global Claude Code rules: shared (code quality, minimal diff, security, logging, naming, testing, commit/PR conventions, `no-auto-push`, `dotfiles-docs`), integrations (`github`, `azure-devops`, `bitbucket`, `jira`), React/TypeScript and .NET/C#. Cursor-style frontmatter so `~/.continue/rules` and `~/.config/crush/rules` can symlink the same files |
| `.claude/output-styles/` | Claude Code output styles. `grumpy-norwegian-sysadmin.md` keeps all work and formatting rules but answers as a deadpan Norwegian sysadmin |

### Window Management — `.config/aerospace/`

[AeroSpace](https://github.com/nikitabobko/AeroSpace) is an i3-like tiling window manager for macOS. It automatically tiles windows, manages workspaces, and provides vim-style keybindings for window/workspace navigation.

| File | Purpose |
|------|---------|
| `config.toml` | AeroSpace tiling WM config (keybindings, gaps, workspace-monitor assignments, floating rules) |
| `layouts.json` | App → workspace placement, root layout per workspace, and optional per-window `width` (percent of monitor width), read by `restore-workspaces.sh` |
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
| `alt-f` | Toggle fullscreen (focused window fills the workspace) |
| `alt-q` | Toggle the workspace's floating windows into the background and back (`float-toggle.sh`) |
| `alt-e` | Snap the Emberward (Wine) window to the top-right corner of the secondary monitor (`emberward-corner.sh`) |

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

*Service mode:* `esc` reload config, `r` reset layout, `f` toggle float/tile, `b` balance window sizes, `backspace` close all windows but current.

### Status Bar — `.config/sketchybar/`

"Vesper" theme (notch black): pure `#000` bar with no border, so the notch blends in; one grey for all status items and a single peach accent (focused workspace, time), Martian Mono (`brew install --cask font-martian-mono`). 32pt on the built-in display so it ends exactly at the bottom of the notch (30pt elsewhere). Left: Apple logo (opens the Apple menu), workspace numbers (the focused one is a peach pill), then the focused app and its window title. Right: `cpu` and `mem` meters, internet (Wi-Fi / ethernet / offline glyph), battery, date and time.

| File | Purpose |
|------|---------|
| `sketchybarrc` | Main SketchyBar config: bar look, defaults, item order |
| `colors.sh` | Theme colours (Vesper) |
| `items/*.sh` | Bar items in use: apple, spaces, front_app (app + window title), cpu, ram, wifi, battery, clock (date + time). `separator` and `volume` are kept but not loaded |
| `plugins/*.sh` | Item scripts. `spaces_update.sh` redraws all workspace items per AeroSpace workspace change (2 `aerospace` calls). `front_app.sh` reads the focused window from AeroSpace on app switch, AeroSpace's `on-focus-changed` hook, and every 3s. |

**Reverting to the previous Tokyo Night bar:** it's saved in the dotfiles tag `sketchybar-tokyo-night`:

```bash
dotfiles checkout sketchybar-tokyo-night -- .config/sketchybar && sketchybar --reload
```

### Window Borders — `.config/borders/`

| File | Purpose |
|------|---------|
| `bordersrc` | JankyBorders config: 2px `square` border |

**Window corner radius (macOS 26):** set system-wide to 6, slightly rounded (macOS 15 used 10; macOS 26's default is 26), with an unofficial preference. `0` is ignored (windows keep 26), not tracked in dotfiles. Apps pick it up when relaunched or after logging out. Some dialogs stay more rounded.

```bash
defaults write -g NSConvolutionOverride1 -float 6    # apply (1 is the smallest that works; 0 is ignored)
defaults delete -g NSConvolutionOverride1            # revert to macOS 26 rounding
```

**macOS window settings for AeroSpace:** not tracked in dotfiles. Each line applies a setting; `defaults delete <domain> <key>` reverts it.

```bash
# Mission Control groups windows by app (AeroSpace parks hidden windows in a corner, so they'd show tiny and scattered otherwise)
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

# One Space set across all displays, recommended by AeroSpace (needs logout; UI: Desktop & Dock → Mission Control → "Displays have separate Spaces" off)
defaults write com.apple.spaces spans-displays -bool true

# Turn off macOS drag-to-tile so it doesn't fight AeroSpace (UI: Desktop & Dock → Windows)
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false

# Drag any window from anywhere with ctrl-cmd (apps pick it up when relaunched)
defaults write -g NSWindowShouldDragOnGesture -bool true
```

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
| `claude-roast.sh` | Claude Code Stop hook: prints a random dark/dev-humour roast as a system message after each turn. |
| `copy-project-env.sh` | Copies gitignored env/config files (`.env`, etc.) from one git project directory to another. Used by `setup-project.sh` to sync env files into worktrees. |
| `dev-env.sh` | Creates a tmux dev session with splits for a given project directory. Work-specific dev scripts live in the untracked `scripts/work/`. |
| `emberward-corner.sh` | Floats the Emberward (Wine) window, moves it to the secondary monitor and snaps it to the top-right corner under SketchyBar, using its current size (the game resizes on resolution changes). Bound to `alt-e`. |
| `float-toggle.sh` | Moves the focused workspace's floating windows (except PiP) to a hidden `bg-<workspace>` stash; run again to bring them back with their positions intact. Bound to `alt-q`. |
| `game-mode.sh` | Quits all running apps except Finder and Steam. Used via the `game-mode` alias. |
| `install_aerospace.sh` | Installs AeroSpace tiling WM and `aerospace-layout-manager` via Homebrew. |
| `install_sketchybar.sh` | Installs SketchyBar and its dependencies (sf-symbols, jq, gh, etc.) via Homebrew. |
| `new-kitty-window.sh` | Opens a plain tiled Kitty window in the currently focused AeroSpace workspace. `new-kitty-window.sh [directory] [command...]` (directory defaults to `~`; an optional command runs inside the new window). Uses `--single-instance` so the window lands on the current workspace instead of spawning a second Kitty instance. Bound to `alt-t` (plain shell) and `alt-c` (`claude-op`). |
| `pip-move.sh` | Moves Picture-in-Picture windows (Firefox/Edge) to the currently focused workspace so PiP follows you when switching workspaces. Runs automatically on workspace change. |
| `popup-kitty.sh` | Floating Kitty popup manager (800x500, translucent, blurred, centered). `popup-kitty.sh <name> [program...]` opens the window once and focuses it on repeat presses. Defaults to `~/ai-sandbox`; override with `POPUP_DIR`. Currently unbound - `alt-c` now opens a tiled window via `new-kitty-window.sh`. |
| `restore-workspaces.sh` | Moves each app in `~/.config/aerospace/layouts.json` to its workspace, sets each workspace's root layout, and applies any window `width` from the file. Reads all windows once, moves only misplaced ones, never changes focus, and launches listed apps that are not running. Bound to `alt-s`. |
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
| `kitty/` | Kitty terminal emulator — config and color theme (Monokai Pro Spectrum); session layouts in `sessions/` are untracked |
| `nvim/` | Neovim config (Lazy.nvim-based, tracked as git submodule) |
| `lazygit/` | Lazygit TUI git client — config (`state.yml` is untracked) |
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
