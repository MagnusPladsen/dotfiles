#!/bin/bash
set -e

current_dir=$(git rev-parse --show-toplevel) || { echo "❌ Not inside a Git repository."; exit 1; }

# Find the main worktree (not the current worktree) to copy env files from
main_worktree=$(git worktree list --porcelain | head -1 | sed 's/^worktree //')

if [ "$main_worktree" = "$current_dir" ]; then
    echo "⚠️  Already in the main worktree, skipping env copy."
else
    echo "📂 Main worktree: $main_worktree"
    source ~/scripts/copy-project-env.sh "$main_worktree" "$current_dir"
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
elif find . -maxdepth 3 -name "*.csproj" -o -name "*.sln" 2>/dev/null | head -1 | grep -q .; then
    # Find the runnable project (Web/API project with OutputType Exe or Sdk Web)
    project=""
    for csproj in $(find . -maxdepth 4 -name "*.csproj" 2>/dev/null); do
        if grep -qE 'Microsoft\.NET\.Sdk\.Web|<OutputType>Exe</OutputType>' "$csproj" 2>/dev/null; then
            project="$csproj"
            break
        fi
    done
    # Fallback: if only one csproj exists, use it
    if [ -z "$project" ]; then
        csproj_count=$(find . -maxdepth 4 -name "*.csproj" 2>/dev/null | wc -l | tr -d ' ')
        if [ "$csproj_count" -eq 1 ]; then
            project=$(find . -maxdepth 4 -name "*.csproj" 2>/dev/null | head -1)
        fi
    fi

    if [ -z "$project" ]; then
        echo "⚠️  Multiple .csproj files found but couldn't determine which to run."
        find . -maxdepth 4 -name "*.csproj" 2>/dev/null | sed 's/^/  /'
    elif grep -ql "Microsoft.EntityFrameworkCore" "$project" 2>/dev/null; then
        echo "🔧 Detected .NET with EF Core — project: $project"
        dotnet ef database update --project "$project"
        dotnet run --project "$project"
    else
        echo "🔧 Detected .NET — project: $project"
        dotnet run --project "$project"
    fi
else
    echo "⚠️  No recognized project type found"
fi
