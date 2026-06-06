#!/bin/bash
set -euo pipefail

REMOTE="origin"
BASE_BRANCH="main"
DIFF_FILE=$(mktemp)
trap 'rm -f "$DIFF_FILE"' EXIT

echo "🔍 Generating diff against $REMOTE/$BASE_BRANCH..."

if ! git fetch "$REMOTE" "$BASE_BRANCH" 2>/dev/null; then
  echo "⚠️  Could not fetch $REMOTE/$BASE_BRANCH, skipping review."
  exit 0
fi

DIFF_RANGE="$REMOTE/$BASE_BRANCH...HEAD"
git diff "$DIFF_RANGE" > "$DIFF_FILE"

if [ ! -s "$DIFF_FILE" ]; then
  echo "✅ No diff to review."
  exit 0
fi

# Count changes
CHANGES=$(wc -l < "$DIFF_FILE")
echo "📝 $CHANGES lines changed."

if command -v opencode &>/dev/null; then
  echo "🤖 Running opencode review..."
  opencode run \
    --dangerously-skip-permissions \
    "Review the following git diff for bugs, security issues, and best practices. Provide concise feedback in Japanese." \
    -f "$DIFF_FILE" || {
    echo "⚠️  opencode review failed (exit code $?), continuing push."
  }
else
  echo ""
  echo "⚠️  opencode not found. Install it to enable AI review:"
  echo "   curl -fsSL https://opencode.ai/install.sh | sh"
  echo ""
  echo "Diff saved to: $DIFF_FILE"
fi
