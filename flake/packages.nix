{ hackgen, nixpkgs, forAllSystems }:
forAllSystems (
  system:
  let
    pkgs = import nixpkgs { inherit system; };
  in
  {
    hackgen = pkgs.stdenvNoCC.mkDerivation {
      pname = "hackgen";
      version = "unstable";
      src = hackgen;
      nativeBuildInputs = [ pkgs.findutils ];
      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/fonts/truetype
        find . -type f -name "*.ttf" -exec cp -v {} $out/share/fonts/truetype/ \;
        runHook postInstall
      '';
    };
  }
)
