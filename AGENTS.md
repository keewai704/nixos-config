# Agents Guide

## Scope
This document provides guidelines for AI agents and automated tools working with this NixOS configuration repository. All commands are intended to be executed on a NixOS host.

## Project Layout
| Path | Description |
|------|-------------|
| `flake.nix` | Flake entrypoint (delegates to `flake/`) |
| `flake/` | Flake outputs split by responsibility |
| `vars/default.nix` | Username and host metadata |
| `lib/default.nix` | System constructors (`mkNixosSystem`) |
| `hosts/<host>/` | Host-specific configuration (system/desktop) |
| `hosts/common/` | Shared host-level configuration |
| `modules/nixos/` | Reusable NixOS modules |
| `home-manager/` | Home Manager entry (home/packages/programs) |
| `secrets/` | Secret examples (never commit `*.yaml`, only `*.example`) |

## Rules
- **One file = one responsibility**: Keep modules focused and cohesive.
- **Prefer Home Manager**: Use Home Manager for user-level packages and configuration.
- **Nix formatting**: Align code with `nix fmt` (uses `nixpkgs-fmt`).
- **No secrets in git**: Never commit `secrets/*.yaml` files.
- **Avoid host-specific code in shared modules**: Keep `hosts/common/` and `modules/` generic.
- **Keep host slices small**: Split `hosts/<host>/` by responsibility (boot, users, locale, desktop, nix, packages).

## Required Commands After Nix File Changes
After modifying any `.nix` file on the NixOS host, execute the following commands every time:

```bash
nix fmt
nix flake check
```

Before finishing your edits, confirm there are no errors by running:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#Citrus
```

If any command fails or produces errors, fix all issues and repeat the same checks.

## Local Development & CI/CD Pipeline
### Local Development (NixOS Native)
Since running NixOS natively, all Nix tools are available locally:

| Command | Purpose |
|---------|---------|
| `nix fmt` | Format code with nixpkgs-fmt |
| `nix flake check` | Validate flake configuration |
| `nix flake update` | Update flake.lock |
| `sudo nixos-rebuild switch` | Apply configuration changes |

### GitHub Actions Workflows
| Workflow | Trigger | Duration | Purpose |
|----------|---------|----------|---------|
| `check.yml` | Push to `main`/`develop`, PRs | ~2-5 min | Runs `nix flake check` and formatting validation |
| `test-vm.yml` | Push to `main`/`develop`, PRs | **10+ min** | Builds and boots Citrus VM for integration testing |
| `flake-maintenance.yml` | Weekly (Monday 3:00 UTC) | ~5 min | Auto-updates `flake.lock` |

### Workflow for Agents
1. Run `nix fmt` and `nix flake check` after each `.nix` change
2. Make the required configuration edits
3. Before finishing, run `nix flake update` and `sudo nixos-rebuild switch --flake .#Citrus`
4. Commit and push to the repository
5. Wait for CI completion:
   - For formatting/check: wait at least 5 minutes
   - For VM tests: wait at least 15 minutes
6. Verify workflow run status on GitHub
7. Resolve all errors if CI fails

> **Critical**: A task is not complete until both local validation passes and all CI checks are green.

## Common Agent Tasks
### Adding a CLI tool via Home Manager
Edit `home-manager/programs.nix` and add the package to the appropriate list.

### Adding a new NixOS module
1. Create `modules/nixos/<module-name>.nix`
2. Import it in the appropriate host's `default.nix`

### Editing Citrus host config
Prefer editing `hosts/citrus/system.nix` or `hosts/citrus/desktop.nix` rather than growing `hosts/citrus/default.nix`.

### Adding a new host
1. Create `hosts/<hostname>/default.nix` and `hardware-configuration.nix`
2. Add the host to `vars/default.nix`
3. Add the nixosConfiguration output in `flake/nixos-configurations.nix`

## Example Prompts
```bash
opencode "Add ripgrep via home-manager/programs.nix and rebuild Citrus"
opencode "Add a new NixOS host 'Mikan' based on Citrus and update flake outputs"
opencode "Nix build failed with: <error>. Find the cause and fix it."
```

## Error Resolution Protocol
### Local Errors
1. Read the full error message from the terminal
2. Identify the root cause: syntax errors, missing imports, incorrect attribute paths, etc.
3. Fix all issues
4. Re-run validation and apply

### CI/CD Errors
1. Read the full error message from the GitHub Actions workflow logs
2. Identify the root cause: syntax errors, missing imports, incorrect attribute paths, etc.
3. Fix all issues locally first
4. Commit and push the corrections
5. Wait and verify that CI passes before finishing

Remember: A task is not complete until both local validation passes and all CI checks are green.
