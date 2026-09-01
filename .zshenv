. "$HOME/.cargo/env"

# Editor. omp resolves its external editor as $VISUAL || $EDITOR
# (packages/coding-agent/src/utils/external-editor.ts); neither was set, so
# /todo edit and friends reported "No editor configured".
# .zshenv (not .zshrc) so non-interactive zsh gets it too.
export EDITOR="nvim"
export VISUAL="nvim"
