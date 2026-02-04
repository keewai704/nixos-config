{ pkgs, vars, inputs, lib, ... }:
{
  imports = [
    ./programs/default.nix
  ];

  home.username = vars.user;
  home.homeDirectory = vars.homeDirectory;
  home.stateVersion = "26.05";

  xdg.enable = true;

  programs.home-manager.enable = true;
}
