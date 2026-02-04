{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    playwright-cli
  ];

  xdg.configFile."playwright-cli/config.json".text = ''
    {
      "browser": "chromium",
      "executablePath": "${lib.getExe pkgs.chromium}"
    }
  '';
}
