# Dev Container Features

A collection of Dev Container Features for development environments.

## Features

### Claude Code CLI Mounts

Mounts host Claude configuration directories into the dev container, enabling Claude Code CLI to use your existing authentication and settings.

**What it does:**
- Mounts `~/.claude.json` and `~/.claude/` from host to container
- Creates symlinks in the container user's home directory
- Preserves your Claude Code authentication across container rebuilds

**Usage:**

```jsonc
// devcontainer.json
{
  "features": {
    "ghcr.io/rafaelkallis/features/claude-code-mounts:1": {}
  }
}
```

**Prerequisites:**
- Claude Code CLI installed on host with existing configuration in `~/.claude/`

## Development

To test a specific feature:

```sh
devcontainer features test -f <feature-id>
```

To publish features:

```sh
devcontainer features publish -r ghcr.io -n rafaelkallis src
```
