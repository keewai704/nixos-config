# Agents Guide

## Scope
This document tells automated tools how to work in this repo.

## Project Layout
- `flake.nix`: inputs and outputs.
- `vars/default.nix`: user and host metadata.
- `lib/default.nix`: system constructors.
- `hosts/<host>/default.nix`: host-specific configuration only.
- `hosts/common/*.nix`: shared host-level configuration.
- `modules/nixos/*.nix`: reusable NixOS modules.
- `home/takahiro/*.nix`: Home Manager entry points.
- `home/takahiro/programs/*.nix`: Home Manager modules by responsibility.
- `overlays/default.nix`: overlays.

## Rules
- Keep one file = one responsibility.
- Prefer Home Manager for user packages/config.
- Keep Nix formatting aligned with `nix fmt`.
- Do not commit secrets (`secrets/*.yaml`).
- Avoid host-specific changes inside shared modules.

## Common Agent Prompts
```bash
opencode "Add ripgrep via home-manager in cli-tools.nix and rebuild Citrus"
opencode "Add a new NixOS host 'Mikan' based on Citrus and update flake outputs"
opencode "Nix build failed with: <error>. Find the cause and fix it."
```

## CI Expectations
- `nix flake check` runs on push.
- VM test is long-running; avoid triggering locally unless needed.
