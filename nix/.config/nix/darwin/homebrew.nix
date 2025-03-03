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
      "rpendleton/homebrew-tap" # lc3 tools
    ];

    # `brew install`
    brews = [
      "aidanaden/tools/canvas-sync"
      "intuis/tap/rustmission"
      "sdl2" # SDL renderer
      "lc3tools" # lc3 tools (for building lc3 .obj files from .asm files)
    ];

    # `brew install --cask`
    casks = [
      "lulu" # outlgoing network detection
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
      "obs" # obs video recording/streaming software
      "focusrite-control-2" # scarlett 2i2 audio interface software
    ];
  };
}
