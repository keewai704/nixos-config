{ config, lib, pkgs, vars, ... }:
let
  addons = pkgs.nur.repos.rycee.firefox-addons;
  photoshow = addons.buildFirefoxXpiAddon {
    pname = "photoshow";
    version = "4.86.1";
    addonId = "photoshow";
    url = "https://addons.mozilla.org/firefox/downloads/file/4672520/photoshow-4.86.1.xpi";
    sha256 = "sha256-zXdkl2xx4398mQeorT6eX8qC4E7N1UVFYTPzXog6T5Q=";
    meta = with lib; {
      homepage = "https://addons.mozilla.org/firefox/addon/photoshow/";
      description = "PhotoShow";
      license = licenses.mpl20;
      platforms = platforms.all;
    };
  };
  chromiumExec = lib.getExe pkgs.chromium;
  firefoxToolbarState = builtins.toJSON {
    placements = {
      "nav-bar" = [
        "back-button"
        "forward-button"
        "stop-reload-button"
        "urlbar-container"
        "downloads-button"
        "ublock0@raymondhill.net"
        "unified-extensions-button"
      ];
      "toolbar-menubar" = [ "menubar-items" ];
      "TabsToolbar" = [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
      "PersonalToolbar" = [ "personal-bookmarks" ];
      "unified-extensions-area" = [ ];
    };
    seen = [
      "ublock0@raymondhill.net"
      "downloads-button"
      "unified-extensions-button"
    ];
    dirtyAreaCache = [ "nav-bar" "TabsToolbar" "PersonalToolbar" "toolbar-menubar" ];
    currentVersion = 20;
    newElementCount = 0;
  };
in
{
  programs = {
    eza.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    bottom.enable = true;
    fastfetch.enable = true;

    npm.enable = true;
    uv.enable = true;
    yt-dlp = {
      enable = true;
      settings = {
        embed-metadata = true;
        embed-subs = true;
      };
    };

    chromium = {
      enable = true;
      package = pkgs.chromium;
      extensions = [
        {
          id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
        }
      ];
    };

    firefox = {
      enable = true;
      languagePacks = [ "ja" ];
      policies = {
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;
        DisableAppUpdate = true;
      };
      profiles.default = {
        settings = {
          "extensions.autoDisableScopes" = 0;
          "intl.accept_languages" = "ja-JP,ja,en-US,en";
          "intl.locale.requested" = "ja-JP";
          "browser.startup.page" = 3;
          "browser.sessionstore.resume_from_crash" = true;
          "browser.eme.ui.enabled" = true;
          "media.eme.enabled" = true;
          "media.gmp-widevinecdm.enabled" = true;
          "media.gmp-widevinecdm.visible" = true;
          "media.gmp-manager.updateEnabled" = true;
          "browser.discovery.enabled" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "privacy.trackingprotection.enabled" = false;
          "privacy.trackingprotection.pbmode.enabled" = false;
          "privacy.trackingprotection.fingerprinting.enabled" = false;
          "privacy.trackingprotection.cryptomining.enabled" = false;
          "privacy.trackingprotection.socialtracking.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "signon.rememberSignons" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "browser.uiCustomization.state" = firefoxToolbarState;

          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.firstRunTelemetry.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.sessionPing.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.prompted" = false;
          "toolkit.telemetry.autoOpts" = false;
          "datareporting.healthreport.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.policy.fourDayNotificationShown" = false;
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
          "browser.contentblocking.category" = "custom";
          "privacy.trackingprotection.smartblock.enabled" = false;
          "privacy.socialtracking.block_cookies.enabled" = false;
          "network.trr.mode" = 0;
          "network.trr.uri" = "";
          "network.dns.disablePrefetchFromHTTPS" = true;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "geo.enabled" = false;
          "geo.provider.useGpsd" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "app.normandy.enabled" = false;
          "app.normandy.runIntervalSeconds" = 100000000;
          "messaging-system.rsexperimentWAA" = false;
          "messaging-system.rwaaOrders" = false;
        };
        extensions.packages = [
          addons.ublock-origin
          photoshow
        ];
      };
    };

    zsh = {
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

    starship = {
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
          format = "[[\${ahead}\${behind}\${staged}\${modified}\${untracked}\${deleted}]($style)]";
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
          format = "[\${symbol}\${version}]($style)";
        };

        python = {
          style = "fg:yellow";
          symbol = "PY ";
          format = "[\${symbol}\${version}]($style)";
        };

        rust = {
          style = "fg:red";
          symbol = "RS ";
          format = "[\${symbol}\${version}]($style)";
        };

        golang = {
          style = "fg:cyan";
          symbol = "GO ";
          format = "[\${symbol}\${version}]($style)";
        };

        status = {
          disabled = false;
          style = "fg:red bold";
          symbol = "✖";
        };
      };
    };

    git = {
      enable = true;
      settings = {
        user.name = vars.gitUsername;
        user.email = vars.gitEmail;
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
      enableGitIntegration = true;
    };
  };

  xdg.desktopEntries = {
    scyrox = {
      name = "Scyrox";
      comment = "Scyrox web app";
      exec = "${chromiumExec} --app=https://www.scyrox.net/ --class=Scyrox";
      icon = "chromium";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
    xsyd-connect = {
      name = "XSYD Connect";
      comment = "XSYD Connect web app";
      exec = "${chromiumExec} --app=https://v2.xsyd.top/connect --class=XSYDConnect";
      icon = "chromium";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
  };

  xdg.configFile."agent-browser/config.json".text = ''
    {
      "browser": "chromium",
      "executablePath": "${lib.getExe pkgs.chromium}"
    }
  '';

  xdg.configFile."ghostty/config" = {
    text = ''
      font-family = "Hack Nerd Font"
    '';
    force = true;
  };

  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    [General]
    Theme=FluentDark-solid
  '';
}
