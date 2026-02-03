{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nur.overlay
    (import ../../overlays { inherit inputs; })
  ];

  imports = [
    ./security.nix
    ./sops.nix
  ];
}
