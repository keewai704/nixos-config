{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.llm-agents.overlays.default
  ];

  imports = [
    ./security.nix
    ./nix-ld.nix
  ];
}
