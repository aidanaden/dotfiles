{
  description = "Thinkpad X1 G7 NixOS configuration with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-zsh-fzf-tab.url = "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";

    zig.url = "github:mitchellh/zig-overlay";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # shamir.url = "github:aidanaden/shamir-zig";
    # schnorr.url = "github:aidanaden/schnorr-zig";
    # flow.url = "github:aidanaden/flow";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    zig,
    neovim-nightly-overlay,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      allowUnfree = true;
      allowUnsupportedSystem = false;
    };
    overlays = with inputs; [zig.overlays.default neovim-nightly-overlay.overlays.default];
    user = "aidan";
    system = "x86_64-linux";
    hostname = "x1";
  in {
    # Nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Replace <your-hostname> with your actual hostname
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      # Makes all inputs availble in imported files
      specialArgs = {inherit inputs;};
      modules = [
        # Add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
        inputs.nix-index-database.nixosModules.nix-index
        # Include results of the hardware scan
        ./hardware-configuration.nix
        ./default.nix
        ({
          pkgs,
          inputs,
          ...
        }: {
          nixpkgs.config = nixpkgsConfig;
          nixpkgs.overlays = overlays;

          system = {
            stateVersion = "5";
            configurationRevision = self.rev or self.dirtyRev or null;
          };

          users.users.${user} = {
            home = "/Users/${user}";
            shell = pkgs.zsh;
            isNormalUser = true;
          };

          networking = {
            hostName = hostname;
          };

          nix = {
            # Enable flakes per default
            package = pkgs.nixFlakes;
            gc = {
              automatic = false;
            };

            settings = {
              allowed-users = [user];
              experimental-features = ["nix-command" "flakes"];
              warn-dirty = false;
              # Produces linking issues when updating on macOS
              # https://github.com/NixOS/nix/issues/7273
              auto-optimise-store = false;

              # Substituers that will be considered before the official ones(https://cache.nixos.org)
              substituters = [
                "https://nix-community.cachix.org"
              ];
              trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              ];
              builders-use-substitutes = true;
            };
          };
        })

        home-manager.nixosModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # Makes all inputs available in imported files for hm
            extraSpecialArgs = {
              inherit inputs;
              pkgs-zsh-fzf-tab =
                import inputs.nixpkgs-zsh-fzf-tab {inherit system;};
            };
            users.${user} = {...}:
              with inputs; {
                imports = [
                  ../shell
                  ../home/nixos.nix
                ];
                home.stateVersion = "24.05";
              };
          };
        }
      ];
    };
  };
}
