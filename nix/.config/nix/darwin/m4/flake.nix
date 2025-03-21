{
  description = "M4 Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-zsh-fzf-tab.url = "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";

    zig.url = "github:mitchellh/zig-overlay";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    shamir.url = "github:aidanaden/shamir-zig";
    schnorr.url = "github:aidanaden/schnorr-zig";
    flow.url = "github:aidanaden/flow";

    mac-app-util.url = "github:hraban/mac-app-util";
    # rustmission.url = "github:intuis/rustmission";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      zig,
      stylix,
      ...
    }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
      };
      overlays = with inputs; [
        zig.overlays.default
      ];
      user = "aidan";
      system = "aarch64-darwin";
      hostname = "m4";
      terminal = "kitty";
    in
    {
      # nix code formatter
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      # nix-darwin with home-manager for macOS
      darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
        inherit system;
        # makes all inputs availble in imported files
        specialArgs = {
          inherit
            inputs
            nixpkgsConfig
            overlays
            user
            hostname
            terminal
            ;
        };
        modules = [
          inputs.nix-index-database.darwinModules.nix-index
          inputs.mac-app-util.darwinModules.default
          ../default.nix
          (
            { pkgs, inputs, ... }:
            {
              system = {
                stateVersion = 5;
                configurationRevision = self.rev or self.dirtyRev or null;
              };
            }
          )
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = {
                inherit inputs stylix terminal;
                pkgs-zsh-fzf-tab = import inputs.nixpkgs-zsh-fzf-tab { inherit system; };
              };
              users.${user} =
                { ... }:
                with inputs;
                {
                  imports = [
                    inputs.nixvim.homeManagerModules.nixvim
                    inputs.spicetify-nix.homeManagerModules.default
                    stylix.homeManagerModules.stylix
                    ../../home/darwin.nix
                    mac-app-util.homeManagerModules.default
                  ];
                  home.stateVersion = "24.11";
                };
            };
          }
        ];
      };
    };
}
