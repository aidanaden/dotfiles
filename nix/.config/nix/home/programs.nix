{
  pkgs,
  inputs,
  terminal,
  ...
}:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home = {
    packages = with pkgs; [
      inputs.neovim-nightly-overlay.packages.${system}.default # text editor

      git
      act # github action runner

      # node
      bun
      unstable.nodejs_20
      unstable.nodePackages.pnpm
      unstable.nodePackages.typescript
      unstable.nodePackages.typescript-language-server

      # rust
      rustup

      # zig
      zigpkgs."0.13.0"

      # go
      goreleaser

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
      mpv

      # torrents
      qbittorrent-qt5

      # discord client
      unstable.vesktop

      # telegram
      telegram-desktop

      # wireguard ui
      unstable.wireguard-ui

      # dog replacement
      dogdns

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
