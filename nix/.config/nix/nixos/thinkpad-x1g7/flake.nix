{
  description = "Lenovo thinkpad x1 gen 7 NixOS configuration";

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

    nix-ld = {
      url = "github:Mic92/nix-ld";
      # this line assume that you also have nixpkgs as an input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-zsh-fzf-tab.url = "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";

    zig.url = "github:mitchellh/zig-overlay";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # shamir.url = "github:aidanaden/shamir-zig";
    # schnorr.url = "github:aidanaden/schnorr-zig";
    # flow.url = "github:aidanaden/flow";
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
      nixos-hardware,
      home-manager,
      # catppuccin,
      zig,
      neovim-nightly-overlay,
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
        neovim-nightly-overlay.overlays.default
      ];
      user = "aidan";
      system = "x86_64-linux";
      hostname = "x1";
      # recommended to convert to 1.25 for 1440p and above
      scale = "1.25";
      terminal = "kitty"; # 'alacritty' or 'kitty'
    in
    {
      # Nix code formatter
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          inherit system;
          # Makes all inputs availble in imported files
          specialArgs = {
            inherit
              inputs
              user
              hostname
              overlays
              nixpkgsConfig
              scale
              terminal
              ;
          };
          modules = [
            (
              { ... }:
              {
                system = {
                  stateVersion = "5";
                  configurationRevision = self.rev or self.dirtyRev or null;
                };
                # UEFI Bootloader
                boot.loader.systemd-boot.enable = true;
                boot.loader.efi.canTouchEfiVariables = true;
              }
            )
            # Add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
            inputs.nix-index-database.nixosModules.nix-index
            # Include results of the hardware scan
            ./hardware-configuration.nix
            ../default.nix
            ../user.nix
            ../fhs-compat.nix
            home-manager.nixosModule
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # Makes all inputs available in imported files for hm
                extraSpecialArgs = {
                  inherit
                    inputs
                    scale
                    stylix
                    terminal
                    ;
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
                      ../../home/nixos.nix
                    ];
                    home.stateVersion = "23.11";
                    # Default scroll speed
                    wayland.windowManager.hyprland.settings.input.touchpad.scroll_factor = 1;
                  };
              };
            }
          ];
        };
      };
    };
}
