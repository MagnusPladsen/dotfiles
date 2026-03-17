#!/bin/bash
set -e

project_dir=$(git rev-parse --show-toplevel) || { echo "❌ Not inside a Git repository."; exit 1; }

# Copy gitignored env/config files into current directory
source ~/scripts/copy-project-env.sh "$project_dir" "."

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
