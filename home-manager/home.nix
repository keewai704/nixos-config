{ vars, ... }:
{
  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;
  home.stateVersion = "26.05";

  xdg.enable = true;

  programs.home-manager.enable = true;
}
