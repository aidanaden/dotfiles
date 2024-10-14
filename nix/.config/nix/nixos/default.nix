{
  pkgs,
  user,
  overlays,
  nixpkgsConfig,
  self,
  ...
}: let
  locale = "en_SG.UTF-8";
in {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  time = {
    timeZone = "Asia/Singapore";
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
      fprintd
      plasma-desktop
      git
    ];
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    scheherazade-new
    ia-writer-duospace
    meslo-lgs-nf
  ];

  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  hardware = {
    pulseaudio.enable = false;

    # Bluetooth support
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs.waybar.enable = true;

  # QT
  qt = {
    # enable = true;
    platformTheme = "qt5ct";
  };

  services = {
    xserver = {
      enable = true;

      # videoDrivers = ["nouveau"];

      xkb = {
        layout = "us";
        variant = "";
      };

      displayManager.gdm.enable = true;
    };

    # Enable fingerprint
    fprintd = {
      enable = true;
      package = pkgs.fprintd-tod;
    };

    # Enable CUPS to print documents
    printing = {
      enable = false;
    };

    # Enable bluetooth manager
    blueman = {
      enable = true;
    };

    # Enable sound with pipewire
    pipewire = {
      enable = true;
      audio = {
        enable = true;
      };
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
      wireplumber = {
        enable = true;
      };

      # If you want to use JACK applications, uncomment this
      # jack = {
      #   enable = true;
      # };
    };

    gvfs = {
      enable = true;
    };

    openssh = {
      enable = true;
    };
  };

  nixpkgs.config = nixpkgsConfig;
  nixpkgs.overlays = overlays;

  nix = {
    # Enable flakes per default
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;

      # Produces linking issues when updating on macOS
      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = true;

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

  programs.firefox.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  programs.hyprland.enable = true; # enable Hyprland
}
