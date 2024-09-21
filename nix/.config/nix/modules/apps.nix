{
  pkgs,
  inputs,
  ...
}: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # text editor
    neovim

    # formatters
    alejandra

    # github
    gh
    git
    act

    # ts/js
    fnm
    bun

    # rust
    rustup

    # zig
    zigpkgs."0.13.0"

    # go
    go
    goreleaser

    # python
    pyenv
    uv
    ruff

    # clickhouse
    clickhouse

    # command line tools
    fzf
    stow
    fd
    jq
    eza
    zoxide
    ripgrep
    tldr
    yazi
    meslo-lgs-nf
    fastfetch
    bat
    btop

    # terminal
    tmux
    kitty

    # tiling + hotkeys
    skhd
    yabai

    # cloud specifi
    flyctl
    turso-cli

    # video
    yt-dlp
    mpv
    # jellyfin-media-player

    # music
    spotify

    # torrents
    qbittorrent-qt5

    # discord client
    vesktop

    # bitwarden
    # bitwarden-desktop

    # telegram
    telegram-desktop

    # tailscale
    tailscale

    # crypto wallets
    trezor-suite

    # shamir cli
    inputs.shamir.default
  ];

  launchd = {
    user = {
      agents = {
        yabai = {
          command = "yabai";
          serviceConfig = {
            KeepAlive = true;
            RunAtLoad = true;
            StandardOutPath = "/tmp/yabai_aidan.out.log";
            StandardErrorPath = "/tmp/yabai_aidan.err.log";
          };
        };
      };
    };
  };

  # # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # #
  # # The apps installed by homebrew are not managed by nix, and not reproducible!
  # # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      "aidanaden/tools"
      "intuis/tap"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "aria2"  # download tool
      "aidanaden/tools/canvas-sync"
      "intuis/tap/rustmission"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      # "google-chrome"
      "spotify"
      "anki"
      "raycast"
    ];
  };
}
