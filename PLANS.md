# Project Plans

## Purpose
This file tracks near-term maintenance goals for this repository. It is not a historical log or a copy of configuration.

## Current Focus (2026-02)
- Normalize structure so each file has a single responsibility.
- Keep documentation short, current, and actionable.
- Make secrets handling explicit and safe by default.
- Keep CI expectations aligned with GitHub Actions.

## Planned Work
- Split Home Manager modules by responsibility and import from `home/takahiro/default.nix`.
- Keep host-specific configuration inside `hosts/<host>/default.nix` only.
- Remove outdated or duplicated documentation.
- Keep instructions for SOPS setup in README only.

## Definition of Done
- `nix flake check` passes in CI on push.
- `nix fmt` is clean when Nix files change.
- Documentation matches current layout and actual commands.
