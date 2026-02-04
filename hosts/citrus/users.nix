{ vars, ... }:
{
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ vars.user ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  programs.zsh.enable = true;
}
