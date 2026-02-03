{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
  };
}
