# nixos-config

Multi-platform Nix flake configuration for:

- Yuzu (WSL2, NixOS-WSL)
- Citrus (NixOS)
- Sudachi (macOS, nix-darwin)

## Requirements

- Nix with flakes enabled
- `just` (optional but recommended)

## Quick Start

```bash
git clone https://github.com/lupo409/nixos-config.git
cd nixos-config
```

## Secrets setup (SOPS)

This repo uses `sops-nix` for secrets. You need an Age key and an encrypted
`secrets/api-keys.yaml` file.

```bash
just init-age
cp secrets/api-keys.yaml.example secrets/api-keys.yaml
just edit-secrets
```

Then add your Age public key to `.sops.yaml` and re-encrypt if needed.

## Host builds

### Yuzu (WSL2)

```bash
just rebuild Yuzu
```

### Citrus (NixOS)

Generate a hardware configuration first:

```bash
sudo nixos-generate-config --show-hardware-config > hosts/citrus/hardware-configuration.nix
```

Then build:

```bash
just rebuild Citrus
```

### Sudachi (macOS)

```bash
just darwin Sudachi
```

## Common maintenance

```bash
just fmt
just check
```

## GitHub Actions

Manual runs (via gh):

```bash
gh workflow run "Flake Check"
gh workflow run "Test NixOS VM"
gh workflow run "Build macOS Configuration"
gh workflow run "Flake Maintenance"
```
