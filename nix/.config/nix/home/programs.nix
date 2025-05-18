{
  pkgs,
  inputs,
  terminal,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
    config.allowUnsupportedSystem = false;
  };
in
{
  home = {
    packages = with pkgs; [
      git
      act # github action runner

      # node
      bun
      unstable.nodejs_20
      unstable.nodePackages.pnpm
      unstable.nodePackages.typescript
      unstable.nodePackages.typescript-language-server

      # node webpack analysing
      nodePackages.webpack
      nodePackages.webpack-cli

      # rush
      nodePackages.rush

      # rust
      rustup

      # go
      unstable.goreleaser

      # make
      gnumake

      # libusb
      libusb1
      pkg-config

      # python
      unstable.python3
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
      mpv-unwrapped

      # torrents
      qbittorrent

      # discord client
      unstable.vesktop

      # telegram
      telegram-desktop

      # wireguard ui
      unstable.wireguard-ui

      # dog replacement
      dogdns

      # lshw alternative
      inxi

      # disk usage analyser
      unstable.ncdu

      # lazyjj
      unstable.lazyjj

      # docker cli
      unstable.lazydocker

      # ps alternative
      unstable.procs

      # diff alternative
      difftastic

      # git lfs
      git-lfs

      # generate books from markdown (gameboy pandocs)
      mdbook

      # note-taking
      obsidian

      # solana dev tools (solana-cli, anchor)
      unstable.solana-cli
      unstable.anchor

      # zig
      unstable.zig

      # local https certs
      mkcert

      # c build tools
      ninja
      cmake
      automake
      autoconf

      # reverse engineering
      ghidra

      # utm virtualisation
      utm

      # sdl cross-platform graphics
      # SDL2
      # sdl3

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

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "${terminal}";
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
      goPrivate = [ ];
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
