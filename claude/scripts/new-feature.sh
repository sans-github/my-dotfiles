#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TODAY=$(date +%Y%m%d)
TEMPLATE="$ROOT/.claude/template"
PROJECTS="$ROOT/projects"

echo ""
echo "New feature setup"
echo "-----------------"

# Prompt for feature name
read -rp "Feature name [${TODAY}-sample-feature]: " FEATURE_NAME
FEATURE_NAME="${FEATURE_NAME:-${TODAY}-sample-feature}"

FEATURE_DIR="$PROJECTS/$FEATURE_NAME"

# Abort if feature folder already exists
if [ -d "$FEATURE_DIR" ]; then
  echo ""
  echo "ERROR: '$FEATURE_DIR' already exists. Aborting to avoid overwrite."
  exit 1
fi

# Create projects/ if needed
mkdir -p "$PROJECTS"

# Copy master only if it doesn't exist yet
if [ -d "$PROJECTS/master" ]; then
  echo ""
  echo "  projects/master already exists -- skipping."
else
  cp -r "$TEMPLATE/master/" "$PROJECTS/master"
  echo "  projects/master created from template."
fi

# Copy feature scaffold
cp -r "$TEMPLATE/feature/" "$FEATURE_DIR"
echo "  projects/$FEATURE_NAME created from template."

echo ""
echo "Next steps:"
echo "  1. Fill in projects/$FEATURE_NAME/workflow/project-config.md"
echo "  2. Write your PRD in projects/$FEATURE_NAME/product-specs/prd.md"
echo "  3. Edit .claude/template/kickoff-brownfield.md (or kickoff-greenfield.md)"
echo "     -- set the feature folder to: projects/$FEATURE_NAME"
echo "  4. Tell Claude: 'Read and execute .claude/template/kickoff-brownfield.md'"
echo ""
