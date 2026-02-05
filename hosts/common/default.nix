{ inputs, ... }:
{
  imports = [
    ./security.nix
    ./nix-ld.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.llm-agents.overlays.default
  ];
}
