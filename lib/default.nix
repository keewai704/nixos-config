{ inputs, vars }:
let
  lib = inputs.nixpkgs.lib;
in
{
  mkNixosSystem = { host }:
    let
      hostConfig = vars.hosts.${host};
      system = hostConfig.system;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ../overlays { inherit inputs; }) ];
      };
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

  mkDarwinSystem = { host }:
    throw "Darwin support removed: ${host}";
}
