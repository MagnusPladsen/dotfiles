# ~/ai-sandbox — AI Working Folder

Sandboxed scratch workspace for ad-hoc AI sessions (`alt-c` opens omp here).
Not a project repo. The name is the safeguard: if an agent reports its working
directory as `ai-sandbox`, nothing outside this folder is the workspace root.
Keep throwaway files here; anything worth keeping belongs in a real repo.

`~` is deliberately NOT the workspace root — omp refuses an exact-`$HOME` cwd and
would otherwise bounce to `/tmp`. Working one level down keeps home out of glob
and grep scope while still inheriting the rules below.

## Rules loaded automatically

No action needed for these — omp already has them in context:

- `~/.claude/CLAUDE.md` — user level, loaded in every directory
- `~/CLAUDE.md` — home directory notes (dotfiles bare repo, tracked paths),
  picked up as an ancestor project file from here

## Rules loaded on demand

`~/.claude/rules/` holds 34 topic rules (symlinks into
`~/.abaris/.claude/rules/`). They are NOT auto-loaded here — Claude Code
glob-matches them per edited file, omp has no equivalent and no `@file` import
syntax. Read the relevant one yourself before working in its domain:

    accessibility  api-integration  azure-devops  bitbucket
    clean-architecture  code-quality  commit-conventions  components
    cqrs-mediatr  csharp  database  dependency-management
    design-consistency  domain-models  dotfiles-docs  error-handling
    github  internationalization  jira  logging  minimal-diff
    naming-conventions  no-auto-push  no-hardcoded-colors  no-phantom-code
    persistence-entities  plan-refinement  pr-conventions
    repository-query-pattern  responsive-web-ui  reusable-code  security
    testing-conventions  typescript

Read all 34 only if the task genuinely spans them; the point of on-demand is to
not pay for C# and CQRS rules during a shell-script fix.

## Editing files outside this folder

`~/.config/**`, `~/scripts/**`, `~/.zshrc` and friends are tracked in the bare
repo at `~/.dotfiles/` via the `dotfiles` alias, per `~/CLAUDE.md`. Read
`~/.claude/rules/dotfiles-docs.md` before touching them, and never commit
without explicit permission.
