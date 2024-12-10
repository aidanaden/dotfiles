{ ... }:
{
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
    brews = [
      "aidanaden/tools/canvas-sync"
      "intuis/tap/rustmission"
      "sdl2" # SDL renderer
    ];

    # `brew install --cask`
    casks = [
      "raycast" # launcher on steroids
      "arc" # mac browser
      "nikitabobko/tap/aerospace" # tiling window manager
      "anki" # japanese learning
      "balenaetcher" # flashing iso
      "trezor-suite" # trezor crypto wallet gui
      "ledger-live" # ledger crypto wallet gui
      "bitwarden" # password manager
      "orbstack"
      "ente-auth" # 2fa manager
      "jellyfin-media-player" # jellyfin player
    ];
  };
}
