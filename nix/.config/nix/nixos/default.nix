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

  # programs.sway.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako # notification daemon
      grim
      #kanshi
      slurp
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.waybar.enable = true;

  # QT
  # programs.qt5ct.enable = true;
  qt.platformTheme = "qt5ct";

  services = {
    xserver = {
      # enable = true;

      videoDrivers = ["nouveau"];

      xkb = {
        layout = "us";
        variant = "";
      };

      # displayManager.sddm.wayland.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.plasma5.enable = true;
      # desktopManager.gnome.enable = true;

      # windowManager = {
      #   qtile.enable = true;
      #   bspwm.enable = true;
      #   dwm.enable = true;
      #
      #   i3 = {
      #     enable = true;
      #     package = pkgs.i3-gaps;
      #     extraPackages = with pkgs; [i3status i3lock polybar];
      #   };
      # };
    };

    # Enable fingerprint
    fprintd = {
      package = pkgs.fprintd-tod;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-vfs0090; # (If the vfs0090 Driver does not work, use the following driver)
        #driver = pkgs.libfprint-2-tod1-goodix; # (On my device it only worked with this driver)
        #driver = pkgs.libfprint-3-tod1-vfs0090;
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

    # Enable touchpad support (enabled default in most desktopManager)
    libinput = {
      enable = true;
    };
  };

  programs.firefox.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  programs.hyprland.enable = true; # enable Hyprland
}
