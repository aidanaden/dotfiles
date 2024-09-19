{
  description = "aidan macos all-in-one flake";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    zig.url = "github:mitchellh/zig-overlay";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs@{ self, nix-darwin, nixpkgs, zig }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
            # text editor
            pkgs.neovim

            # github
            pkgs.gh
            pkgs.git
            pkgs.act

            # node/ts/js
            pkgs.fnm
            pkgs.bun

            # rust
            pkgs.rustup

            # zig
            pkgs.zigpkgs."0.13.0"

            # go
            pkgs.go
            pkgs.goreleaser

            # python
            pkgs.pyenv
            pkgs.uv

            # clickhouse
            pkgs.clickhouse

            # command line tools
            pkgs.fzf
            pkgs.stow
            pkgs.fd
            pkgs.jq
            pkgs.eza
            pkgs.zoxide
            pkgs.ripgrep
            pkgs.tldr
            pkgs.yazi
            pkgs.meslo-lgs-nf
            pkgs.fastfetch
            pkgs.bat
            pkgs.btop

            # terminal
            pkgs.tmux
            pkgs.kitty

            # tiling + hotkeys
            pkgs.skhd
            pkgs.yabai
            
            # cloud specifi
            pkgs.flyctl
            pkgs.turso-cli

            # media
            pkgs.yt-dlp
            pkgs.mpv
            # pkgs.jellyfin-media-player

            # torrents
            pkgs.qbittorrent-qt5

            # discord client
            pkgs.vesktop

            # bitwarden
            # pkgs.bitwarden-desktop

            # spotify
            pkgs.spotify

            # telegram
            pkgs.telegram-desktop

            # tailscale
            pkgs.tailscale
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;

      # Declare the user that will be running `nix-darwin`.
      users.users.aidan = {
        name = "aidan";
        home = "/Users/aidan";
      };

      # Set zig version to 0.13.0
      nixpkgs.overlays = [zig.overlays.default];

      security.pam.enableSudoTouchIdAuth = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#m1
    darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."m1".pkgs;
  };
}
