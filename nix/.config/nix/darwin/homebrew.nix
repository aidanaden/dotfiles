{...}: {
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
    ];

    # `brew install --cask`
    casks = [
      "spotify" # music player
      "raycast" # launcher on steroids
      # "arc" # mac browser
      "nikitabobko/tap/aerospace" # tiling window manager
      "anki" # japanese learning
      "balenaetcher" # flashing iso
      # "bitwarden" # password manager
      # "orbstack"
    ];
  };
}
