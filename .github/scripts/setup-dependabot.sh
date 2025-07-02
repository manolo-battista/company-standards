#!/bin/bash
set -e

PROJECT_TYPE=$1
REPO_DIR=$2

if [ ! -f "$REPO_DIR/.github/dependabot.yml" ]; then
  mkdir -p "$REPO_DIR/.github"
  case "$PROJECT_TYPE" in
    elixir)
      cp "$REPO_DIR/.github/templates/dependabot-elixir.yml" "$REPO_DIR/.github/dependabot.yml"
      ;;
    nextjs)
      cp "$REPO_DIR/.github/templates/dependabot-nextjs.yml" "$REPO_DIR/.github/dependabot.yml"
      ;;
    *)
      echo "Unknown project type: $PROJECT_TYPE"
      exit 1
      ;;
  esac
  cd "$REPO_DIR"
  git add .github/dependabot.yml
  git commit -m "Add dependabot config for $PROJECT_TYPE"
  git push
else
  echo "Dependabot config already exists, skipping"
fi
