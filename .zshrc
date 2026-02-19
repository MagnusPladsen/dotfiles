export PATH="$HOME/Library/Python/3.11/bin:$PATH"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Environment variables
if [ -f ~/.env ]; then
  export $(cat ~/.env | grep -v '^#' | xargs)
fi


# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"



# Enable vim mode
# bindkey -v

# set up alias for dotfiles git repo
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='/usr/bin/git --git-dir=/Users/magnuspladsen/.dotfiles/ --work-tree=/Users/magnuspladsen'

# aliases for EZA
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
alias claude-notes='cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ Vault && claude --dangerously-skip-permissions'

# opencode
export PATH=/Users/magnuspladsen/.opencode/bin:$PATH

# android simulator
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
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

# thefuck alias
eval $(thefuck --alias)

# bat as default git pager
#export GIT_PAGER="bat --color=always --paging=never"

export PATH="$HOME/.cargo/bin:$PATH"

# Azure DevOps PR shortcut for fraktas-app
azpr() {
  open "https://dev.azure.com/fraktas/markedsplass/_git/fraktas-app/pullrequestcreate?sourceRef=$(git branch --show-current)&targetRef=${1:-main}"
}

# Use port 5038 for ADB to avoid conflict with backend on 5037
export ANDROID_ADB_SERVER_PORT=5038

# Git worktree helper function.
# Use it like this:
# wt feature-name
wt() {
    # Get the current Git project directory (must be inside a Git repo)
    local project_dir
    project_dir=$(git rev-parse --show-toplevel) || { echo "❌ Not inside a Git repository."; return 1; }

    # Get the base name of the current project folder
    local project_name=$(basename "$project_dir")

    # Get the desired feature/branch name from the first argument
    local feature_name="$1"

    # Fail fast if no feature name was provided
    if [ -z "$feature_name" ]; then
        echo "❌ Usage: wt <feature-name>"
        return 1
    fi

    # Define the parent folder where all worktrees go, beside the main repo
    local worktree_parent="$(dirname "$project_dir")/${project_name}-worktrees"

    # Define the full path of the new worktree folder
    local worktree_path="${worktree_parent}/${feature_name}"

    # Create the parent worktrees folder if it doesn't exist
    mkdir -p "$worktree_parent"

    # If the folder already exists, check if it's a worktree for a different branch
    if [ -d "$worktree_path" ]; then
        local existing_branch
        existing_branch=$(git -C "$worktree_path" rev-parse --abbrev-ref HEAD 2>/dev/null) || existing_branch=""

        if [ "$existing_branch" = "$feature_name" ]; then
            echo "✅ Worktree '$feature_name' already exists at $worktree_path"
        else
            echo "🔄 Folder exists with branch '${existing_branch:-none}', replacing with '$feature_name'..."
            # Try git worktree remove first; if that fails (not a registered worktree), just delete the folder
            if ! git -C "$project_dir" worktree remove --force "$worktree_path" 2>/dev/null; then
                rm -rf "$worktree_path"
            fi
            git -C "$project_dir" worktree prune
        fi
    fi

    # Create the worktree if the folder doesn't exist (either never existed or was just removed)
    if [ ! -d "$worktree_path" ]; then
        if git -C "$project_dir" show-ref --verify --quiet "refs/heads/$feature_name"; then
            git -C "$project_dir" worktree add "$worktree_path" "$feature_name" || { echo "❌ Failed to create worktree."; return 1; }
        else
            git -C "$project_dir" worktree add -b "$feature_name" "$worktree_path" || { echo "❌ Failed to create worktree."; return 1; }
        fi
    fi

    # Copy all gitignored dotfiles and dotfolders into the worktree
    for item in "$project_dir"/.*; do
        local name=$(basename "$item")
        # Skip . , .. , and .git
        [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]] && continue
        if git -C "$project_dir" check-ignore -q "$item" 2>/dev/null; then
            if [ -d "$item" ]; then
                cp -R "$item" "$worktree_path/$name"
                echo "📁 Copied $name into worktree."
            elif [ -f "$item" ]; then
                cp "$item" "$worktree_path/$name"
                echo "📋 Copied $name into worktree."
            fi
        fi
    done

    # Copy gitignored environment config files (e.g. appsettings.Development.json)
    # from anywhere in the project tree, preserving directory structure
    # Covers: .NET, JS/TS, React, Svelte, Spring Boot, Django, Docker, Cloudflare
    local config_files
    config_files=$(git -C "$project_dir" ls-files --others --ignored --exclude-standard 2>/dev/null | \
        grep -iE '(appsettings\..+\.json$|\.env(\.|$)|local\.settings\.json$|secrets\.json$|\.user$|docker-compose\.override\.ya?ml$|application-.+\.(properties|ya?ml)$|local_settings\.py$|\.dev\.vars$|wrangler\.toml$)') || true
    if [ -n "$config_files" ]; then
        echo "$config_files" | while IFS= read -r file; do
            mkdir -p "$worktree_path/$(dirname "$file")"
            cp "$project_dir/$file" "$worktree_path/$file"
            echo "📋 Copied $file into worktree."
        done
    fi

    # Open the worktree in Zed, fallback to VS Code
    if command -v zed &> /dev/null; then
        zed "$worktree_path" &
    elif command -v code &> /dev/null; then
        code "$worktree_path" &
    else
        echo "⚠️  Neither Zed nor VS Code found. Open manually: $worktree_path"
    fi

    # Confirm success
    echo "✅ Worktree '$feature_name' created at $worktree_path and checked out."
}

wt-close() {
    # Get the current Git project directory (must be inside a Git repo)
    local project_dir
    project_dir=$(git rev-parse --show-toplevel) || { echo "❌ Not inside a Git repository."; return 1; }

    local project_name=$(basename "$project_dir")
    local feature_name="$1"

    if [ -z "$feature_name" ]; then
        echo "❌ Usage: wt-close <feature-name>"
        return 1
    fi

    local worktree_parent="$(dirname "$project_dir")/${project_name}-worktrees"
    local worktree_path="${worktree_parent}/${feature_name}"

    # Check if the folder exists at all
    if [ ! -d "$worktree_path" ]; then
        echo "❌ No worktree folder found at $worktree_path"
        return 1
    fi

    # Don't allow closing the worktree we're currently inside
    local current_dir=$(pwd -P)
    if [[ "$current_dir" == "$worktree_path"* ]]; then
        echo "❌ You are inside this worktree. cd out of it first."
        return 1
    fi

    # Try git worktree remove (handles both clean and --force cases)
    if git -C "$project_dir" worktree remove "$worktree_path" 2>/dev/null; then
        echo "✅ Worktree '$feature_name' removed."
    elif git -C "$project_dir" worktree remove --force "$worktree_path" 2>/dev/null; then
        echo "✅ Worktree '$feature_name' force-removed (had uncommitted changes)."
    else
        # Not a registered worktree, just a leftover folder
        rm -rf "$worktree_path"
        git -C "$project_dir" worktree prune
        echo "✅ Removed leftover folder '$feature_name' and pruned worktree list."
    fi
}

# Added by CodeRabbit CLI installer
export PATH="/Users/magnuspladsen/.local/bin:$PATH"
