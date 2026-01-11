{
  pkgs,
  user,
  overlays,
  hostname,
  nixpkgsConfig,
  ...
}:
{
  imports = [ ./homebrew.nix ];

  nixpkgs.config = nixpkgsConfig;
  nixpkgs.overlays = overlays;

  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  networking = {
    computerName = hostname;
    hostName = hostname;
    localHostName = hostname;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
    };
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    scheherazade-new
    ia-writer-duospace
    meslo-lgs-nf
    monaspace
    departure-mono
    noto-fonts
    kanji-stroke-order-font
  ];

  services = {
    # Auto upgrade nix package and the daemon service.
    tailscale.enable = true;
  };

  nix = {
    optimise = {
      automatic = true;
    };

    gc = {
      automatic = true;
    };

    settings = {
      allowed-users = [ user ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      # produces linking issues when updating on macOS
      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = false;

      # substituers that will be considered before the official ones(https://cache.nixos.org)
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      builders-use-substitutes = true;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  system = {
    primaryUser = user;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    # activationScripts.postUserActivation.text = ''
    #   # activateSettings -u will reload the settings from the database and apply them to the current session,
    #   # so we do not need to logout and login again to make the changes take effect.
    #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    # '';

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
        showhidden = true;
        static-only = true;
        persistent-apps = [
          "/Users/${user}/Applications/Home Manager Apps/Telegram.app"
          "/Users/${user}/Applications/Home Manager Apps/Vesktop.app"
          "/Users/${user}/Applications/Home Manager Apps/Spotify.app"
          "/Users/${user}/Applications/Home Manager Apps/kitty.app"
          "/Users/${user}/Applications/Home Manager Apps/qbittorrent.app"
          "/Applications/Raycast.app"
          "/Applications/Arc.app"
          "/Applications/Bitwarden.app"
        ];
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = true; # enable three finger drag
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      menuExtraClock = {
        ShowAMPM = false;
        ShowDate = 1; # Always
        Show24Hour = true;
        ShowSeconds = false;
      };

      # other macOS's defaults configuration.
      # ......
      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
          InitialKeyRepeat = 10;
          KeyRepeat = 2;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          "_HIHideMenuBar" = false;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.controlcenter" = {
          BatteryShowPercentage = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 0;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Downloads";
          type = "png";
        };
        "com.apple.print.PrintingPrefs" = {
          # Automatically quit printer app once the print jobs complete
          "Quit When Finished" = true;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 0;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
        };
        "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
        # Turn on app auto-update
        "com.apple.commerce".AutoUpdate = true;

        # "com.apple.Safari" = {
        #   # Privacy: don’t send search queries to Apple
        #   UniversalSearchEnabled = false;
        #   SuppressSearchSuggestions = true;
        #   # Press Tab to highlight each item on a web page
        #   WebKitTabToLinksPreferenceKey = true;
        #   ShowFullURLInSmartSearchField = true;
        #   # Prevent Safari from opening ‘safe’ files automatically after downloading
        #   AutoOpenSafeDownloads = false;
        #   ShowFavoritesBar = false;
        #   IncludeInternalDebugMenu = true;
        #   IncludeDevelopMenu = true;
        #   WebKitDeveloperExtrasEnabledPreferenceKey = true;
        #   WebContinuousSpellCheckingEnabled = true;
        #   WebAutomaticSpellingCorrectionEnabled = false;
        #   AutoFillFromAddressBook = false;
        #   AutoFillCreditCardData = false;
        #   AutoFillMiscellaneousForms = false;
        #   WarnAboutFraudulentWebsites = true;
        #   WebKitJavaEnabled = false;
        #   WebKitJavaScriptCanOpenWindowsAutomatically = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
        # };

        # "com.apple.mail" = {
        #   # Disable inline attachments (just show the icons)
        #   DisableInlineAttachmentViewing = true;
        # };
      };
    };
  };
}
