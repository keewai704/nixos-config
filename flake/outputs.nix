{ inputs }:
let
  vars = import ../vars/default.nix;
  lib = import ../lib { inherit inputs vars; };
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
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
  packages = forAllSystems (system: { });
  formatter = import ./formatter.nix {
    inherit forAllSystems;
    nixpkgs = inputs.nixpkgs;
  };
}
