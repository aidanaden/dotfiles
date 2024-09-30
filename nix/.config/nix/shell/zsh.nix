{
  pkgs,
  pkgs-zsh-fzf-tab,
  ...
}: {
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
      [ -s "/Users/aidan/.bun/_bun" ] && source "/Users/aidan/.bun/_bun"

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
    ];

    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      pmodules = ["autosuggestions" "directory" "editor" "git" "terminal"];
    };
  };
}
