#!/bin/bash
# Git worktree helper functions
# Usage: wt feature-name       — create worktree
#        wt-close feature-name  — remove worktree

wt() {
    local project_dir
    project_dir=$(git rev-parse --show-toplevel) || { echo "❌ Not inside a Git repository."; return 1; }

    local project_name=$(basename "$project_dir")
    local feature_name="$1"

    if [ -z "$feature_name" ]; then
        echo "❌ Usage: wt <feature-name>"
        return 1
    fi

    local worktree_parent="$(dirname "$project_dir")/${project_name}-worktrees"
    local worktree_path="${worktree_parent}/${feature_name}"

    mkdir -p "$worktree_parent"

    if [ -d "$worktree_path" ]; then
        local existing_branch
        existing_branch=$(git -C "$worktree_path" rev-parse --abbrev-ref HEAD 2>/dev/null) || existing_branch=""

        if [ "$existing_branch" = "$feature_name" ]; then
            echo "✅ Worktree '$feature_name' already exists at $worktree_path"
        else
            echo "🔄 Folder exists with branch '${existing_branch:-none}', replacing with '$feature_name'..."
            if ! git -C "$project_dir" worktree remove --force "$worktree_path" 2>/dev/null; then
                rm -rf "$worktree_path"
            fi
            git -C "$project_dir" worktree prune
        fi
    fi

    if [ ! -d "$worktree_path" ]; then
        if git -C "$project_dir" show-ref --verify --quiet "refs/heads/$feature_name"; then
            git -C "$project_dir" worktree add "$worktree_path" "$feature_name" || { echo "❌ Failed to create worktree."; return 1; }
        else
            git -C "$project_dir" worktree add -b "$feature_name" "$worktree_path" MAIN || { echo "❌ Failed to create worktree."; return 1; }
        fi
    fi

    # Copy gitignored dotfiles into the worktree
    for item in "$project_dir"/.*; do
        local name=$(basename "$item")
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

    # Copy gitignored config files preserving directory structure
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

    # Open in a new cmux workspace named after the branch
    if command -v cmux &> /dev/null && [ -S /tmp/cmux.sock ]; then
        local ws_output ws_id
        ws_output=$(cmux --socket /tmp/cmux.sock new-workspace 2>&1)
        ws_id=$(echo "$ws_output" | awk '{print $2}')
        if [ -n "$ws_id" ]; then
            cmux --socket /tmp/cmux.sock rename-workspace --workspace "$ws_id" "$feature_name"
            cmux --socket /tmp/cmux.sock select-workspace --workspace "$ws_id"
            sleep 0.3
            cmux --socket /tmp/cmux.sock send --workspace "$ws_id" "cd '$worktree_path'"$'\n'
        else
            echo "⚠️  cmux new-workspace failed: $ws_output"
        fi
    else
        echo "⚠️  cmux not found or socket missing. Open manually: $worktree_path"
    fi

    echo "✅ Worktree '$feature_name' created at $worktree_path and checked out."
}

wt-close() {
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

    if [ ! -d "$worktree_path" ]; then
        echo "❌ No worktree folder found at $worktree_path"
        return 1
    fi

    local current_dir=$(pwd -P)
    if [[ "$current_dir" == "$worktree_path"* ]]; then
        echo "❌ You are inside this worktree. cd out of it first."
        return 1
    fi

    if git -C "$project_dir" worktree remove "$worktree_path" 2>/dev/null; then
        echo "✅ Worktree '$feature_name' removed."
    elif git -C "$project_dir" worktree remove --force "$worktree_path" 2>/dev/null; then
        echo "✅ Worktree '$feature_name' force-removed (had uncommitted changes)."
    else
        rm -rf "$worktree_path"
        git -C "$project_dir" worktree prune
        echo "✅ Removed leftover folder '$feature_name' and pruned worktree list."
    fi
}
