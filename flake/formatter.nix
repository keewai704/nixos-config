{ nixpkgs, forAllSystems }:
forAllSystems (
  system:
  let
    pkgs = import nixpkgs { inherit system; };
  in
  pkgs.nixpkgs-fmt
)
