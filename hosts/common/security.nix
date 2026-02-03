{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      PubkeyAuthentication = true;
      X11Forwarding = false;
    };
  };

  services.fail2ban.enable = true;
}
