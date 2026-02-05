{ inputs }:
let
  vars = import ../vars/default.nix;
  lib = import ../lib { inherit inputs vars; };
  systems = [ "x86_64-linux" ];
  forAllSystems = f:
    builtins.listToAttrs (map
      (system: {
        name = system;
        value = f system;
      })
      systems);
in
{
  nixosConfigurations = import ./nixos-configurations.nix { inherit lib; };
  packages = import ./packages.nix {
    inherit forAllSystems;
    hackgen = inputs.hackgen;
    nixpkgs = inputs.nixpkgs;
  };
  formatter = import ./formatter.nix {
    inherit forAllSystems;
    nixpkgs = inputs.nixpkgs;
  };
}
