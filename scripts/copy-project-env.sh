#!/bin/bash
# Copy gitignored environment/config files from one directory to another.
# Usage: copy-project-env.sh <source_dir> <target_dir>
#   source_dir: git project root to copy from
#   target_dir: destination directory

source_dir="$1"
target_dir="$2"
copied_count=0

if [ -z "$source_dir" ] || [ -z "$target_dir" ]; then
    echo "❌ Usage: copy-project-env.sh <source_dir> <target_dir>"
    return 1 2>/dev/null || exit 1
fi

# Resolve to absolute paths and bail if same directory
source_dir=$(cd "$source_dir" && pwd -P)
target_dir=$(cd "$target_dir" && pwd -P)
if [ "$source_dir" = "$target_dir" ]; then
    echo "⚠️  Source and target are the same directory, skipping."
    return 0 2>/dev/null || exit 0
fi

echo "🔍 Scanning for gitignored env/config files in $source_dir..."

# Copy gitignored dotfiles (e.g. .env, .env.local)
for item in "$source_dir"/.*; do
    name=$(basename "$item")
    [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]] && continue
    if git -C "$source_dir" check-ignore -q "$item" 2>/dev/null; then
        if [ -d "$item" ]; then
            cp -R "$item" "$target_dir/$name"
            echo "📁 Copied $name (directory)"
            copied_count=$((copied_count + 1))
        elif [ -f "$item" ]; then
            cp "$item" "$target_dir/$name"
            echo "📋 Copied $name"
            copied_count=$((copied_count + 1))
        fi
    fi
done

# Copy gitignored .claude files (e.g. settings.local.json)
if [ -d "$source_dir/.claude" ]; then
    claude_ignored=$(cd "$source_dir" && find .claude -type f 2>/dev/null | while read -r f; do
        git check-ignore -q "$f" 2>/dev/null && echo "$f"
    done) || true
    if [ -n "$claude_ignored" ]; then
        echo "$claude_ignored" | while IFS= read -r file; do
            mkdir -p "$target_dir/$(dirname "$file")"
            cp "$source_dir/$file" "$target_dir/$file"
            echo "📋 Copied $file"
            copied_count=$((copied_count + 1))
        done
    fi
fi

# Copy gitignored config files (appsettings, .env variants, docker overrides, etc.)
config_files=$(git -C "$source_dir" ls-files --others --ignored --exclude-standard 2>/dev/null | \
    grep -iE '(appsettings\..+\.json$|\.env(\.|$)|local\.settings\.json$|secrets\.json$|\.user$|docker-compose\.override\.ya?ml$|application-.+\.(properties|ya?ml)$|local_settings\.py$|\.dev\.vars$|wrangler\.toml$)') || true
if [ -n "$config_files" ]; then
    echo "$config_files" | while IFS= read -r file; do
        mkdir -p "$target_dir/$(dirname "$file")"
        cp "$source_dir/$file" "$target_dir/$file"
        echo "📋 Copied $file"
        copied_count=$((copied_count + 1))
    done
fi

if [ "$copied_count" -eq 0 ]; then
    echo "⚠️  No gitignored env/config files found to copy."
else
    echo "✅ Copied $copied_count file(s) from $source_dir to $target_dir"
fi
