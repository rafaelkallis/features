#!/bin/sh
set -eu

echo "Activating feature 'claude-code-mounts'"

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
