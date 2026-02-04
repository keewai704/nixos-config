{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    chromium
  ];

  programs.npm = {
    enable = true;
    packageLock = false;
    globalPackages = [
      "playwright-cli"
    ];
  };

  home.sessionVariables = {
    PLAYWRIGHT_BROWSERS_PATH = "${config.home.homeDirectory}/.cache/ms-playwright";
  };
}
