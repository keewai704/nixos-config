{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden-desktop
    obs-studio
    prismlauncher
    mpv
    dust
    nano
    ghostty
    graalvmPackages.graalvm-ce
    deno
    ffmpeg
    llm-agents.opencode
    llm-agents.claude-code
    llm-agents.agent-browser
    (python3.withPackages (ps: [
      ps.certifi
      ps.brotli
      ps.curl-cffi
      ps.mutagen
      ps.xattr
      ps.pycryptodomex
    ]))
  ];
}
