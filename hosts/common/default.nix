{ inputs, lib, ... }:
{
  imports = [
    ./security.nix
    ./nix-ld.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "wpsoffice"
  ];

  nixpkgs.overlays = [
    inputs.nur.overlays.default
    (final: _prev: { })
  ];
}
