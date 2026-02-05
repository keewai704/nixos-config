{ config, pkgs, lib, vars, inputs, ... }:
let
  initrdModulesRoot = pkgs.runCommand "initrd-modules-root" { allowSubstitutes = false; preferLocalBuild = true; } ''
    mkdir -p $out
    ln -s ${config.system.build.modulesClosure}/lib/modules $out/modules
    if [ -d ${config.system.build.modulesClosure}/lib/firmware ]; then
      ln -s ${config.system.build.modulesClosure}/lib/firmware $out/firmware
    fi
  '';
in
{
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.contents."/lib".source = lib.mkForce initrdModulesRoot;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.supportedLocales = [ "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ vars.username ];
    substituters = [ "https://cache.numtide.com" ];
    trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    home = vars.homeDirectory;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ vars.username ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    dgop
    papirus-icon-theme
  ];

  fonts.packages = with pkgs; [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.hackgen
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans CJK JP" "Noto Sans CJK" ];
      serif = [ "Noto Serif CJK JP" "Noto Serif CJK" ];
      monospace = [ "Hack Nerd Font" "HackGen Console" "HackGen" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
