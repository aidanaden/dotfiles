{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-zsh-fzf-tab.url = "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";

    zig.url = "github:mitchellh/zig-overlay";
    shamir.url = "github:aidanaden/shamir-zig";
    schnorr.url = "github:aidanaden/schnorr-zig";
    flow.url = "github:aidanaden/flow";
    # rustmission.url = "github:intuis/rustmission";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    zig,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      allowUnfree = true;
      allowUnsupportedSystem = false;
    };
    # overlays = with inputs; [feovim.overlay krewfile.overlay];
    user = "aidan";
    system = "aarch64-darwin";
    hostname = "m1";
  in {
    # nix code formatter
    # formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    # nix-darwin with home-manager for macOS
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      inherit system;
      # makes all inputs availble in imported files
      specialArgs = {inherit inputs;};
      modules = [
        inputs.nix-index-database.darwinModules.nix-index
        ./darwin
        ({
          pkgs,
          inputs,
          ...
        }: {
          nixpkgs.config = nixpkgsConfig;
          # nixpkgs.overlays = overlays;

          system = {
            stateVersion = 5;
            configurationRevision = self.rev or self.dirtyRev or null;
          };

          users.users.${user} = {
            home = "/Users/${user}";
            shell = pkgs.zsh;
          };

          networking = {
            computerName = hostname;
            hostName = hostname;
            localHostName = hostname;
          };

          nix = {
            # enable flakes per default
            package = pkgs.nixFlakes;
            gc = {
              automatic = false;
              user = user;
            };
            settings = {
              allowed-users = [user];
              experimental-features = ["nix-command" "flakes"];
              warn-dirty = false;
              # produces linking issues when updating on macOS
              # https://github.com/NixOS/nix/issues/7273
              auto-optimise-store = false;
            };
          };
        })
        home-manager.darwinModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # makes all inputs available in imported files for hm
            extraSpecialArgs = {
              inherit inputs;
              pkgs-zsh-fzf-tab =
                import inputs.nixpkgs-zsh-fzf-tab {inherit system;};
            };
            users.${user} = {...}:
              with inputs; {
                imports = [./home ./shell];
                home.stateVersion = "24.11";
              };
          };
        }
      ];
    };
  };
}
