# NVIDIA configuration for RTX 5070 Ti (Blackwell architecture)
{ config, pkgs, ... }:
{
  # Enable graphics support (OpenGL/Vulkan)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For 32-bit applications (Steam games, etc.)
  };

  # NVIDIA driver configuration
  hardware.nvidia = {
    # Use the latest driver for RTX 5070 Ti (Blackwell)
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # Enable modesetting for Wayland support
    modesetting.enable = true;

    # Use the open kernel module (recommended for RTX 50 series)
    open = true;

    # Enable NVIDIA settings
    nvidiaSettings = true;

    # Power management for suspend/resume
    powerManagement = {
      enable = true;
      finegrained = false;
    };
  };

  # Load NVIDIA kernel module
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # Blacklist nouveau driver
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Set NVIDIA as video driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable Docker with NVIDIA container toolkit (optional, for GPU containers)
  # virtualisation.docker.enableNvidia = true;
}
