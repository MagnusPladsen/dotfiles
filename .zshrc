# ── PATH ─────────────────────────────────────────────────────────
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Android SDK
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
export ANDROID_ADB_SERVER_PORT=5038

# ── Powerlevel10k instant prompt (must stay near top) ────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Oh My Zsh ────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ── p10k config ──────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ── Environment variables from ~/.env ────────────────────────────
if [ -f ~/.env ]; then
  set -a
  source ~/.env
  set +a
fi

# ── Shell tools ──────────────────────────────────────────────────
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
eval $(thefuck --alias)

# ── Aliases ──────────────────────────────────────────────────────
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='eza --color=always --icons=always --long --git --no-filesize --no-time --no-user --no-permissions --group-directories-first'
alias ll='eza -lah --icons=always --group-directories-first'
alias tree='eza --tree --level=2'
alias sauce="source ~/.zshrc && echo '~/.zshrc reloaded'"
alias t='tmux '
alias ta='tmux a'
alias macos='pkill AeroSpace sketchybar borders'
alias tiles='open -a "AeroSpace" && ~/.config/aerospace/run-aerospace-layout-manager.sh'
alias pattymode='pkill AeroSpace sketchybar && open -a "Google Chrome"'
alias git-merge='git mergetool --tool=nvimdiff --no-prompt'
alias bupgrade='brew upgrade'
alias claude='claude --teammate-mode auto'
alias claude-notes='cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ Vault && claude --dangerously-skip-permissions'
alias claude-op='claude --dangerously-skip-permissions'

# ── FZF + fd config ──────────────────────────────────────────────
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1"; }

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ── Helper functions ─────────────────────────────────────────────
# Azure DevOps PR shortcut
azpr() {
  open "https://dev.azure.com/fraktas/markedsplass/_git/fraktas-app/pullrequestcreate?sourceRef=$(git branch --show-current)&targetRef=${1:-main}"
}

# Git worktree helpers (wt / wt-close)
source ~/scripts/worktrees.sh

# Added by Antigravity
export PATH="/Users/magnuspladsen/.antigravity/antigravity/bin:$PATH"
