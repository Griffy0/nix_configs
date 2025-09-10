#!/bin/zsh

# Usage: ./git_push.sh "Commit message"

if [[ -z "$1" ]]; then
  echo "Error: No commit message provided."
  exit 1
fi

COMMIT_MSG="$1"
REPO_DIR="/etc/nixos"
README="$REPO_DIR/README.md"
TMP_TREE="/tmp/nixos_tree.txt"
TMP_README="/tmp/README_tmp.md"
START_MARKER="<!-- TREE_START -->"
END_MARKER="<!-- TREE_END -->"

# Ensure README exists
if [[ ! -f "$README" ]]; then
  echo "Creating README.md..."
  sudo touch "$README"
fi

# Generate tree output
sudo tree -a -L 2 "$REPO_DIR" > "$TMP_TREE"

# Wrap tree in code block
TREE_BLOCK="\`\`\`\n$(cat "$TMP_TREE")\n\`\`\`"

# Read the original README
sudo cp "$README" "$TMP_README"

# Replace or insert tree section
if grep -q "$START_MARKER" "$TMP_README"; then
  # Replace existing section
  sudo awk -v start="$START_MARKER" -v end="$END_MARKER" -v tree="$TREE_BLOCK" '
    BEGIN {in_block=0}
    {
      if ($0 ~ start) {
        print $0
        print tree
        in_block=1
        next
      }
      if ($0 ~ end) {in_block=0}
      if (!in_block) print $0
    }' "$TMP_README" | sudo tee "$README" > /dev/null
else
  # Append section at the end
  {
    cat "$TMP_README"
    echo
    echo "$START_MARKER"
    echo "$TREE_BLOCK"
    echo "$END_MARKER"
  } | sudo tee "$README" > /dev/null
fi

# Git add and commit
cd "$REPO_DIR" || exit
sudo git add .
sudo git commit -m "$COMMIT_MSG"

# Cleanup
rm "$TMP_TREE" "$TMP_README"

echo "README.md updated and changes committed."
