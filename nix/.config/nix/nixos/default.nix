{pkgs, ...}: let
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

    # Enable sound with pipewire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };

      # If you want to use JACK applications, uncomment this
      # jack = {
      #   enable = true;
      # };
    };
  };

  programs.firefox.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  programs.hyprland.enable = true; # enable Hyprland
}
