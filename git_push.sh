#!/usr/bin/env zsh

# File to update
README="README.md"

# Directory to generate tree for (current directory by default)
DIR="."

# Check if commit message was provided
if [[ -z "$1" ]]; then
  echo "Usage: $0 <commit-message>"
  exit 1
fi

COMMIT_MSG="$1"

# Temporary file for the tree output
TREE_TMP=$(mktemp)

# Generate full tree, excluding .git and flake.lock
/etc/profiles/per-user/anon/bin/tree -I '.git|flake.lock|git_push.sh' "$DIR" > "$TREE_TMP"

# Replace old tree content between markers in README.md
sed -i.bak "/<!-- TREE_START -->/,/<!-- TREE_END -->/{//!d}" "$README"  # delete old content
sed -i "/<!-- TREE_START -->/r $TREE_TMP" "$README"                     # insert new tree

# Wrap tree output in Markdown code block
sed -i '/<!-- TREE_START -->/a ```' "$README"
sed -i '/<!-- TREE_END -->/i ```' "$README"

# Clean up
rm $TREE_TMP

sudo git add .
sudo git commit -m "$COMMIT_MSG"
sudo git push origin master

echo "Updated $README and committed with message: $COMMIT_MSG"
