# CLAUDE.md — Home Directory

## Dotfile Management

- **Bare git repo** at `~/.dotfiles/` — always use the `dotfiles` alias, NEVER regular `git`
- Workflow: `dotfiles add <file> && dotfiles commit -m "msg" && dotfiles push`
- `.gitignore` uses allowlist pattern: `/*` ignores everything, `!` exceptions whitelist tracked files
- **Tracked:** `.vimrc`, `.zshrc`, `.tmux.conf`, `.gitignore`, `.claude/{settings.json,output-styles/}`, `.claude/{mods,skills,rules}/` (submodules: public `claude-mods` / `claude-skills` / `claude-rules` repos — commit inside them with plain `git`, then bump the pointer with `dotfiles`), `scripts/`, `LaunchAgents/`, `fzf-git.sh/`, `.config/{nvim,espanso,sketchybar,ghostty,aerospace,borders,lazygit,zed,television}/`
- **Not tracked (intentional):** `.gitconfig` (machine-specific), `.p10k.zsh`
- **TODO:** `.config/kitty/` should be added to dotfiles tracking (currently missing)
- **README:** `~/README.md` documents all tracked configs, scripts, aliases, and keybindings

## Key Paths & Tools

| Path | Purpose |
|------|---------|
| `~/git/` | Repos (worktrees in `~/git/*-worktrees/`) |
| `~/scripts/` | Personal scripts |
| `~/.config/` | App configs (aerospace, sketchybar, kitty, ghostty, nvim, lazygit, zed, borders, espanso, television) |
| `~/.claude/skills/` | Claude Code skills (submodule `claude-skills`; third-party skills gitignored) |
| `~/.claude/mods/` | Claude Code mods (submodule `claude-mods`) |
| `~/.claude/rules/` | Claude Code global rules (submodule `claude-rules`) |
| `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault` | Personal Obsidian vault — use `claude-notes` alias |

Work-specific context (work remotes, work vault, work helpers) lives in an untracked file:

@.claude/work-context.md

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
- **Terminals:** Kitty, Ghostty
- **Terminal editors:** Neovim (Lazy.nvim config), Vim

## Television (tv) — Fuzzy Finder

**tv** (television) is a fast, hackable TUI fuzzy finder. Config at `~/.config/television/`.

Channels, keybindings, shell triggers and channel editing: the `television` skill (`~/.claude/skills/television/`).

## Behavior Rules

- **Keep asks short and scannable** — see `## Response Formatting` below for the
  full rule, including where asks and disclosures must go.
- **Always ask before modifying `.zshrc`** — critical config, easy to break
- **Prefer bun over npm** as package manager
- **Use `dotfiles` alias** for any git operations on home directory configs (not `git`)
- **Use `claude-notes` alias** when working on the personal Obsidian vault
- **Never commit secrets/tokens** — extra caution with `.env`, API keys, credentials

## Response Formatting

Applies to every chat response that asks me something or tells me something specific
I need to know, decide, or disclose. Does not apply to the interactive question modal
(`AskUserQuestion`), which stays as it is.

### Must
- Group related content under short bold or `###` headers. No wall of prose.
- Write points, not paragraphs. One idea per point.
- Keep every point to one or two lines. Cut hedging, preamble, and restatement.
- Lead each point with the thing itself, then the detail.
- Name specifics: file, symbol, ticket key, value, path. Never "some places" or
  "a few things".

### Asks and disclosures must not float in the text

Anything I have to act on goes in a dedicated block at the end of the response, never
mixed into the informational body. Push the blocks well clear of the body: a blank
line, two `---` rules separated by a blank line, then the header. The double rule
renders as a visible gap band in every markdown renderer, where extra blank lines
alone would collapse.

```

---

---

## ❓ NEEDS YOUR CALL

## ⚠️ HEADS UP
```

- `❓ NEEDS YOUR CALL` — questions, decisions, and anything blocking further work.
- `⚠️ HEADS UP` — caveats, things deliberately not done, unverified claims, risks
  accepted.
- `##`, caps, and the coloured marker are the point: the block must be impossible to
  miss when skimming. Do not soften them to `###`, sentence case, or a bare arrow.
- The double rule goes before the first block only. Never between the two blocks.
- Both go last, in that order. Exception: if the whole task is blocked, put
  `❓ NEEDS YOUR CALL` first so it is the first thing read.
- Number the items inside each block so I can answer "1 and 3".
- Omit a block entirely when it is empty. Never manufacture an ask to fill it.
- One of each per response. Merge related items rather than repeating the header.
- These are the only two emoji used in a response. Do not add emoji anywhere else.

### Avoid
- Burying a question, decision, or caveat in a body point. It belongs in a block above.
- Ending on an informational point when something is still waiting on me.
- Explaining what you are about to say before saying it.
- Repeating a point in a summary line after already making it.
- Long quoted excerpts when a reference and one line will do.

## macOS Window Management

- **AeroSpace** (tiling WM) — `.config/aerospace/`
- **SketchyBar** (status bar) — `.config/sketchybar/`
- **Borders** (window decoration) — `.config/borders/`
- Restart all: `macos` alias · Launch tiling: `tiles` alias

## Development Context

- **Personal GitHub:** MagnusPladsen
- **Work:** see the untracked work context imported above
- **Languages:** TypeScript/JS, Python, Rust, C#
- **Git:** delta for diffs, worktree aliases (`wta`, `wtl`, `wtr`)
- **Git identity per repo:** the global `user.email` is the work address. Personal repos
  (remote under `github.com/MagnusPladsen/`, including the dotfiles bare repo and its
  submodules) must commit as `Magnus Pladsen <93226629+MagnusPladsen@users.noreply.github.com>`.
  Before the first commit in a personal repo, check `git config user.email`; if it is the work
  address, set the no-reply address with `git config --local user.email`. Never let the work
  email land in a personal repo's history.
