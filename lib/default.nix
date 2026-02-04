{ inputs, vars }:
let
  lib = inputs.nixpkgs.lib;
in
{
  mkNixosSystem = { host }:
    let
      hostConfig = vars.hosts.${host};
      system = hostConfig.system;
    in
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs vars;
      };
      modules = [
        ./../hosts/${lib.strings.toLower host}/default.nix
      ];
    };

}
