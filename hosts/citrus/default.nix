{ config, inputs, vars, pkgs, ... }:
let
  initrdModulesRoot = pkgs.runCommand "initrd-modules-root" { } ''
    mkdir -p $out
    ln -s ${config.system.build.modulesClosure}/lib/modules $out/modules
    if [ -d ${config.system.build.modulesClosure}/lib/firmware ]; then
      ln -s ${config.system.build.modulesClosure}/lib/firmware $out/firmware
    fi
  '';
in
{
  imports = [
    ../common/default.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.dankmaterialshell.nixosModules.dank-material-shell
    ./hardware-configuration.nix
    ../../modules/nixos/secure-boot.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/wayland.nix
    ../../modules/nixos/fcitx5.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/pipewire.nix
    ../common/nix-ld.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.initrd.systemd.suppressedStorePaths = [ "${config.system.build.modulesClosure}/lib" ];
  boot.initrd.systemd.storePaths = [
    {
      source = initrdModulesRoot;
      target = "/lib";
    }
  ];

  networking.hostName = "Citrus";

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  programs.zsh.enable = true;

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

  programs.dsearch = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs vars;
    };
    users.${vars.user} = import ../../home/takahiro/default.nix;
  };

  environment.systemPackages = with pkgs; [
    dgop
  ];

  fonts.packages = with pkgs; [
    hackgen
    noto-fonts-cjk-sans
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
