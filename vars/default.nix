let
  username = "takahiro";
in
{
  inherit username;
  homeDirectory = "/home/${username}";
  gitUsername = "Lupo409";
  gitEmail = "249657796+lupo409@users.noreply.github.com";

  hosts = {
    Citrus = {
      system = "x86_64-linux";
      type = "nixos";
    };
  };
}
