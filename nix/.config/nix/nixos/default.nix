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

  programs.sway.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # wayland.windowManager.sway = {
  #   enable = true;
  #   config = rec {
  #     modifier = "Mod4"; # Super key
  #     terminal = "kitty";
  #     output = {
  #       "Virtual-1" = {
  #         mode = "2560x1440@60Hz";
  #       };
  #     };
  #   };
  #   extraConfig = ''
  #     bindsym Print               exec shotman -c output
  #     bindsym Print+Shift         exec shotman -c region
  #     bindsym Print+Shift+Control exec shotman -c window
  #   '';
  # };

  services = {
    displayManager.sddm.wayland.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
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

  # Enable touchpad support (enabled default in most desktopManager)
  #services.xserver.libinput.enable = true;

  programs.firefox.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
}
