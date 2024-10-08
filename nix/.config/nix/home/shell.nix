{
  pkgs,
  inputs,
  ...
}: let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./btop.nix
    ./bat.nix
    ./yazi.nix
  ];

  home = {
    packages = with pkgs; [
      inputs.neovim-nightly-overlay.packages.${system}.default # text editor

      alejandra # nix formatter

      git
      act # github action runner

      # node
      fnm
      bun
      nodePackages.pnpm
      nodePackages.typescript
      nodePackages.typescript-language-server

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
      ripgrep
      tldr
      meslo-lgs-nf
      fastfetch

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
      unstable.vesktop

      # telegram
      telegram-desktop

      # tailscale
      tailscale

      # wireguard ui
      unstable.wireguard-ui

      # crypto wallets

      # shamir cli
      # inputs.shamir.packages.${pkgs.system}.default

      # schnorr cli
      # inputs.schnorr.packages.${pkgs.system}.default

      # flow terminal
      # inputs.flow.packages.${pkgs.system}.default

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
      vim = "nvim";
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
    nushell.enable = true; # zsh alternative
    broot.enable = true; # browser big folders
    eza.enable = true;

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
        "--color fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
      ];
    };
  };
}
