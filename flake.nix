{
  description = "NixOS multi-platform configuration";

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    dankmaterialshell = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hackgen = {
      url = "github:yuru7/HackGen";
      flake = false;
    };

  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      vars = import ./vars/default.nix;
      lib = import ./lib { inherit inputs vars; };
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
      nixosConfigurations = {
        Citrus = lib.mkNixosSystem { host = "Citrus"; };
      };

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          hackgen = pkgs.stdenvNoCC.mkDerivation {
            pname = "hackgen";
            version = "unstable";
            src = inputs.hackgen;
            nativeBuildInputs = [ pkgs.findutils ];
            installPhase = ''
              runHook preInstall
              mkdir -p $out/share/fonts/truetype
              find . -type f -name "*.ttf" -exec cp -v {} $out/share/fonts/truetype/ \;
              runHook postInstall
            '';
          };
        }
      );


      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.nixpkgs-fmt
      );
    };
}
