#!/bin/bash
set -euo pipefail

REMOTE="origin"
BASE_BRANCH="main"
DIFF_FILE=$(mktemp)
RESULT_FILE=$(mktemp)
trap 'rm -f "$DIFF_FILE" "$RESULT_FILE"' EXIT

echo "Generating diff against $REMOTE/$BASE_BRANCH..."

if ! git fetch "$REMOTE" "$BASE_BRANCH" 2>/dev/null; then
  echo "Could not fetch $REMOTE/$BASE_BRANCH, skipping review."
  exit 0
fi

DIFF_RANGE="$REMOTE/$BASE_BRANCH...HEAD"
git diff "$DIFF_RANGE" > "$DIFF_FILE"

if [ ! -s "$DIFF_FILE" ]; then
  echo "No diff to review."
  exit 0
fi

CHANGES=$(wc -l < "$DIFF_FILE")
echo "$CHANGES lines changed."

if ! command -v opencode &>/dev/null; then
  echo "opencode not found. Install it to enable AI review:"
  echo "  curl -fsSL https://opencode.ai/install.sh | sh"
  echo "Diff saved to: $DIFF_FILE"
  exit 0
fi

echo "Running opencode review..."

opencode run \
  --dangerously-skip-permissions \
  "Review the following git diff for bugs, security issues, and best practices.
Rate each finding with a severity prefix: [B] Blocker, [H] High, [M] Medium, [L] Low.

[B] = security vulnerability, data loss, breaking change, incorrectness
[H] = logic error, potential runtime failure, reproducibility issue
[M] = code smell, maintainability concern, minor performance
[L] = style, readability, nitpick

Every finding line MUST start with the severity prefix like '[H] description'.
After all findings, output a line exactly like: RESULT: X blocker, Y high, Z medium, W low" \
  -f "$DIFF_FILE" 2>&1 | tee "$RESULT_FILE"

# Count blocking issues (Blocker + High)
BLOCKER=$(grep -cE '^\s*\[B\]' "$RESULT_FILE" 2>/dev/null || true)
HIGH=$(grep -cE '^\s*\[H\]' "$RESULT_FILE" 2>/dev/null || true)
BLOCK_COUNT=$((BLOCKER + HIGH))

if [ "$BLOCK_COUNT" -gt 0 ]; then
  echo ""
  echo "BLOCKING PUSH: $BLOCKER blocker(s), $HIGH high severity issue(s) found."
  exit 1
else
  echo ""
  echo "No blocking issues found. Push allowed."
  exit 0
fi
