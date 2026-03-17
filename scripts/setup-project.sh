#!/bin/bash
set -e

project_dir=$(git rev-parse --show-toplevel) || { echo "❌ Not inside a Git repository."; exit 1; }

# Copy gitignored dotfiles (e.g. .env, .env.local)
for item in "$project_dir"/.*; do
    name=$(basename "$item")
    [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]] && continue
    if git -C "$project_dir" check-ignore -q "$item" 2>/dev/null; then
        if [ -d "$item" ]; then
            cp -R "$item" "./$name"
            echo "📁 Copied $name"
        elif [ -f "$item" ]; then
            cp "$item" "./$name"
            echo "📋 Copied $name"
        fi
    fi
done

# Copy gitignored .claude files (e.g. settings.local.json)
if [ -d "$project_dir/.claude" ]; then
    claude_ignored=$(cd "$project_dir" && find .claude -type f 2>/dev/null | while read -r f; do
        git check-ignore -q "$f" 2>/dev/null && echo "$f"
    done) || true
    if [ -n "$claude_ignored" ]; then
        echo "$claude_ignored" | while IFS= read -r file; do
            mkdir -p "./$(dirname "$file")"
            cp "$project_dir/$file" "./$file"
            echo "📋 Copied $file"
        done
    fi
fi

# Copy gitignored config files (appsettings, .env variants, docker overrides, etc.)
config_files=$(git -C "$project_dir" ls-files --others --ignored --exclude-standard 2>/dev/null | \
    grep -iE '(appsettings\..+\.json$|\.env(\.|$)|local\.settings\.json$|secrets\.json$|\.user$|docker-compose\.override\.ya?ml$|application-.+\.(properties|ya?ml)$|local_settings\.py$|\.dev\.vars$|wrangler\.toml$)') || true
if [ -n "$config_files" ]; then
    echo "$config_files" | while IFS= read -r file; do
        mkdir -p "./$(dirname "$file")"
        cp "$project_dir/$file" "./$file"
        echo "📋 Copied $file"
    done
fi

# Detect runtime and install/run
if [ -f "package.json" ]; then
    if [ -f "bun.lockb" ] || [ -f "bun.lock" ]; then
        echo "📦 Detected bun"
        bun install
    elif [ -f "pnpm-lock.yaml" ]; then
        echo "📦 Detected pnpm"
        pnpm install
    elif [ -f "yarn.lock" ]; then
        echo "📦 Detected yarn"
        yarn install
    else
        echo "📦 Detected npm"
        npm ci
    fi
    # Fallback: create .env from example if nothing was copied
    [ ! -f .env ] && [ -f .env.example ] && cp .env.example .env && echo "📋 Created .env from .env.example"
elif [ -f "*.csproj" ] || [ -f "*.sln" ] || ls *.csproj *.sln 2>/dev/null | head -1 > /dev/null 2>&1; then
    if find . -name "*.csproj" -exec grep -l "Microsoft.EntityFrameworkCore" {} \; 2>/dev/null | head -1 > /dev/null 2>&1; then
        echo "🔧 Detected .NET with EF Core"
        dotnet ef database update
        dotnet run
    else
        echo "🔧 Detected .NET"
        dotnet run
    fi
else
    echo "⚠️  No recognized project type found"
fi
