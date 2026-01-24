# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Dev Container Features monorepo containing custom features for development environments. Currently includes:

- **claude-code-mounts**: Mounts host Claude CLI configuration (`~/.claude/` and `~/.claude.json`) into dev containers via bind mounts and symlinks.

## Commands

```bash
# Test a specific feature
devcontainer features test -f <feature-name>

# Test with custom remote user
devcontainer features test -f <feature-name> --remote-user root

# Run global cross-feature tests
devcontainer features test --global-scenarios-only .

# Publish features to GitHub Container Registry
devcontainer features publish -r ghcr.io -n <namespace> src
```

## Architecture

### Directory Structure
- `src/<feature-name>/` - Feature source code
  - `devcontainer-feature.json` - Feature manifest (metadata, options, dependencies)
  - `install.sh` - Installation script (runs as root)
- `test/<feature-name>/` - Feature test suites
  - `test.sh` - Default test (runs with default options)
  - `scenarios.json` - Test configurations for different option combinations
- `test/_global/` - Cross-feature integration tests

### Key Patterns
- **Option-to-Environment Variable Mapping**: Feature options in the manifest become uppercase environment variables in install.sh (e.g., `greeting` option becomes `$GREETING`)
- **Test Library**: Tests use `dev-container-features-test-lib` with `check` and `reportResults` commands
- **Feature Dependencies**: Use `installsAfter` in manifest to control installation order
