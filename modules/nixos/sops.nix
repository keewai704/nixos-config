{ inputs, pkgs, vars, config, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    validateSopsFiles = false;
    age = {
      keyFile = "/etc/sops/age/keys.txt";
      generateKey = true;
    };

    # githubとtailscaleはsopsを使わない
    # secrets."github/token".owner = vars.username;
    # secrets."tailscale/authkey".owner = vars.username;
    secrets."dms/weather_coordinates" = {
      owner = vars.username;
    };
    secrets."user/username" = { };
    secrets."user/hashedPassword" = {
      owner = "root";
      mode = "0400";
    };
  };

  environment.systemPackages = with pkgs; [
    sops
    ssh-to-age
    age
    age-plugin-yubikey
    jq
  ];
}
