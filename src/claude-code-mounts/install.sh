#!/bin/sh
set -eu

echo "Activating feature 'claude-code-mounts'"

# Check if Claude Code CLI is installed
if ! command -v claude >/dev/null 2>&1; then
    cat <<EOF

ERROR: Claude Code CLI is required but not installed!
Please add the Claude Code feature to your devcontainer.json:

  "features": {
    "ghcr.io/anthropics/devcontainer-features/claude-code:1": {},
    "ghcr.io/rafaelkallis/features/claude-code-mounts:1": {}
  }

EOF
    exit 1
fi

# Backup existing files/directories if they exist and are not already symlinks
for target in .claude .claude.json; do
    path="$_REMOTE_USER_HOME/$target"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        echo "Backing up existing $path to $path.bak"
        mv "$path" "$path.bak"
    fi
done

# Create symlinks from the user's home directory to the mounted locations
ln -sf /mnt/.claude "$_REMOTE_USER_HOME/.claude"
ln -sf /mnt/.claude.json "$_REMOTE_USER_HOME/.claude.json"

chown -h "$_REMOTE_USER:$_REMOTE_USER" "$_REMOTE_USER_HOME/.claude" "$_REMOTE_USER_HOME/.claude.json"
