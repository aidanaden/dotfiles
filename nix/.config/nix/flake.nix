{
  description = "aidan macos all-in-one flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    zig.url = "github:mitchellh/zig-overlay";
  };

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
            pkgs.skhd
            pkgs.tmux
            pkgs.yabai
            pkgs.kitty
            
            # cloud specific
            pkgs.flyctl
            pkgs.turso-cli

            # misc
            pkgs.yt-dlp
            pkgs.mpv
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
