{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    dotDir = config.home.homeDirectory;

    history = {
      size = 100000;
      save = 100000;
      share = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    completionInit = ''
      autoload -Uz compinit
      compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
    '';

    shellAliases = {
      ls = "eza";
      cat = "bat";
      ll = "eza -la --icons";
      lt = "eza --tree --level=2";
      grep = "rg";
      fgrep = "rg";
      egrep = "rg";
      ".." = "cd ..";
      "..." = "cd ../..";
      la = "eza -la";
      vim = "nvim";
      vi = "nvim";
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
    };

    initContent = lib.mkOrder 1000 ''
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"

      export EDITOR=nvim

      setopt HIST_IGNORE_SPACE
      setopt HIST_IGNORE_ALL_DUPS
      setopt AUTO_CD
      setopt CORRECT
      setopt NO_BEEP
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[┌](bold blue)"
        "[ ](bg:blue fg:blue)"
        "[ ](bg:blue fg:black)"
        "[│](bold blue)"
        "[ ](bg:none fg:blue)"
        "$directory"
        "[ ](bg:none fg:blue)"
        "[│](bold blue)"
        "[ ](bg:none fg:blue)"
        "$git_branch"
        "$git_status"
        "[ ](bg:none fg:blue)"
        "[│](bold blue)"
        "[ ](bg:none fg:blue)"
        "$nodejs"
        "$python"
        "$rust"
        "$golang"
        "[ ](bg:none fg:blue)"
        "[│](bold blue)"
        "[ ](bg:none fg:blue)"
        "$status"
      ];
      add_newline = false;
      line_break.disabled = true;

      palette = "tokyonight";

      palettes.tokyonight = {
        black = "#15161E";
        blue = "#7aa2f7";
        cyan = "#7dcfff";
        green = "#9ece6a";
        magenta = "#bb9af7";
        red = "#f7768e";
        white = "#c0caf5";
        yellow = "#e0af68";
      };

      directory = {
        style = "fg:magenta bold";
        truncation_length = 3;
        truncate_to_repo = false;
      };

      git_branch = {
        style = "fg:green";
        symbol = "";
      };

      git_status = {
        style = "fg:red";
        format = "[[$ahead$behind$staged$modified$untracked$deleted]($style)]";
        ahead = "↑";
        behind = "↓";
        staged = "●";
        modified = "●";
        untracked = "●";
        deleted = "✖";
      };

      nodejs = {
        style = "fg:green";
        symbol = "JS ";
        format = "[${symbol}${version}]($style)";
      };

      python = {
        style = "fg:yellow";
        symbol = "PY ";
        format = "[${symbol}${version}]($style)";
      };

      rust = {
        style = "fg:red";
        symbol = "RS ";
        format = "[${symbol}${version}]($style)";
      };

      golang = {
        style = "fg:cyan";
        symbol = "GO ";
        format = "[${symbol}${version}]($style)";
      };

      status = {
        disabled = false;
        style = "fg:red bold";
        symbol = "✖";
      };
    };
  };

  home.packages = with pkgs; [
    starship
  ];
}
