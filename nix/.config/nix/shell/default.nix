{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./git.nix
  ];

  home = {
    packages = with pkgs; [
      neovim # text editor

      alejandra # nix formatter

      git
      act # github action runner

      # node
      fnm
      bun
      nodePackages.pnpm

      # rust
      rustup

      # zig
      zigpkgs."0.13.0"

      # go
      goreleaser

      # python
      pyenv
      uv
      ruff

      # clickhouse
      clickhouse

      # command line tools
      stow
      fd
      jq
      eza
      ripgrep
      tldr
      meslo-lgs-nf
      fastfetch

      # terminal
      tmux
      kitty

      # cloud specific
      flyctl
      turso-cli
      google-cloud-sdk

      # video
      yt-dlp
      mpv

      # torrents
      qbittorrent-qt5

      # discord client
      vesktop

      # telegram
      telegram-desktop

      # tailscale
      tailscale

      # crypto wallets

      # shamir cli
      inputs.shamir.packages.${pkgs.system}.default

      # schnorr cli
      inputs.schnorr.packages.${pkgs.system}.default

      # flow terminal
      inputs.flow.packages.${pkgs.system}.default

      # rustmission
      # inputs.rustmission.packages.${pkgs.system}.default
    ];

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
    };

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
    };
  };

  programs = {
    # let home-manager manage itself
    home-manager.enable = true;

    go = {
      enable = true;
      package = pkgs.go_1_22;
      goPath = "go";
      goBin = "go/bin";
      goPrivate = [];
    };

    # shell integrations are enabled by default
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    yazi.enable = true; # file browser
    btop.enable = true; # htop alternative
    nushell.enable = true; # zsh alternative
    broot.enable = true; # browser big folders

    # pretty ls
    lsd = {
      enable = true;
      enableAliases = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor --exclude node_modules";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
      ];
    };
  };
}
