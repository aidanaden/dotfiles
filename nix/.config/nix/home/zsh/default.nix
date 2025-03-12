{ pkgs, pkgs-zsh-fzf-tab, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      del = "rm -rf";
      lst = "ls --tree -I .git";
      lsl = "ls -l";
      lsa = "ls -a";
      null = "/dev/null";

      # overrides
      cat = "bat";
      top = "btop";
      htop = "btop";
      ping = "gping";
      diff = "delta";
      ssh = "TERM=screen ssh";
      python = "python3";
      pip = "python3 -m pip";
      venv = "python3 -m venv";
      pn = "pnpm";
      vim = "nvim";
      dig = "dog";
      # lazyjj shortcut
      lj = "lazyjj";
      # jj shortcut
      j = "jj";
      # ps alternative
      ps = "procs";
    };

    # initExtraFirst = ''
    #   source ~/.p10k.zsh
    # '';

    initExtra = ''
      # yazi
      function yy() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      	yazi "$@" --cwd-file="$tmp"
      	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		cd -- "$cwd"
      	fi
      	rm -f -- "$tmp"
      }
      # yazi end

      # bun completions
      [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

      # tmux list sessions on startup
      function _tmux()
      {
          if [[ $# == 0 ]] && command tmux ls >& /dev/null; then
              command tmux attach \; choose-tree -s
          else
              command tmux "$@"
          fi
      }

      alias tmux=_tmux

      # eval "$(fnm env)"

      export VI_MODE_SET_CURSOR=true

      export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
      export PATH="/opt/homebrew/Cellar/zigup/2025.01.02/bin:$PATH"
    '';

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
      {
        name = "fzf-tab";
        src = "${pkgs-zsh-fzf-tab.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [];
    # };

    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      prompt = {
        theme = "off";
      };
      pmodules = [
        "autosuggestions"
        "directory"
        "editor"
        "git"
        "terminal"
      ];
    };
  };
}
