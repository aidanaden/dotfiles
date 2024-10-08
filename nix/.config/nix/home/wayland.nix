{
  pkgs,
  inputs,
  ...
}: let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  home.packages = with pkgs; [
    waybar
    swww
    qt5-wayland
    qt6-wayland
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    NIXOS_OZONE_WL = 1;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    catppuccin = {
      enable = true;
    };

    extraConfig = ''
      # Fix slow startup
      # exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      # exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

      # Autostart
      # exec-once = hyprctl setcursor Bibata-Modern-Classic 24
      exec-once = dunst

      # source = /home/enzo/.config/hypr/colors
      # exec = pkill waybar & sleep 0.5 && waybar
      exec-once = swww init & sleep 0.5 && exec wallpaper_random

      exec-once = ${unstable.vesktop}/bin/vesktop
    '';

    settings = {
      "$terminal" = "kitty";
      "$mod" = "SUPER";

      monitor = [
        ",prefered,auto,1.15"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      general = {
        gaps_in = 6;
        gaps_out = 6;
        border_size = 2;
        layout = "dwindle";
        col.active_border = "rgb(7AA2F7)";
        col.inactive_border = "rgb A9B1D6";
        allow_tearing = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
        accel_profile = "flat";
        sensitivity = 0;
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      decoration = {
        drop_shadow = false;
        blur = {
          enabled = false;
        };
      };

      animations = {
        enabled = false;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      cursor = {
        enable_hyprcursor = true;
      };

      bind = [
        # General
        "$mod, return, exec, $terminal"
        "$mod SHIFT, q, killactive"
        "$mod SHIFT, e, exit"
        "$mod SHIFT, p, pseudo"
        "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

        # Screen focus
        "$mod, v, togglefloating"
        "$mod, u, focusurgentorlast"
        "$mod, tab, focuscurrentorlast"
        "$mod, f, fullscreen"

        # Screen resize
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, l, resizeactive, 20 0"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, j, resizeactive, 0 20"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspaces
        "$mod SHIFT, 1, movetoworkspace,1"
        "$mod SHIFT, 2, movetoworkspace,2"
        "$mod SHIFT, 3, movetoworkspace,3"
        "$mod SHIFT, 4, movetoworkspace,4"
        "$mod SHIFT, 5, movetoworkspace,5"
        "$mod SHIFT, 6, movetoworkspace,6"
        "$mod SHIFT, 7, movetoworkspace,7"
        "$mod SHIFT, 8, movetoworkspace,8"
        "$mod SHIFT, 9, movetoworkspace,9"
        "$mod SHIFT, 0, movetoworkspace,10"

        # Navigation
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Applications
        "$mod ALT, f, exec, ${pkgs.firefox}/bin/firefox"
        "$mod ALT, v, exec, ${unstable.vesktop}/bin/vesktop"
        # "$mod ALT, e, exec, $terminal --hold -e ${pkgs.yazi}/bin/yazi"
        # "$mod ALT, o, exec, ${pkgs.obsidian}/bin/obsidian"
        # "$mod, r, exec, pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
        # "$mod ALT, r, exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
        "$mod ALT, n, exec, swaync-client -t -sw"

        # Clipboard
        "$mod ALT, v, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

        # Screencapture
        # "$mod, S, exec, ${pkgs.grim}/bin/grim | wl-copy"
        # "$mod SHIFT+ALT, S, exec, ${pkgs.grim}/bin/grim -g \"$(slurp)\" - | ${pkgs.swappy}/bin/swappy -f -"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
        "workspace 1 silent, class:^(kitty)$"
        "workspace 3 silent, class:^(firefox)$"
        "workspace 4 silent, class:^(vesktop)$"

        # firefox Picture-in-Picture
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
      ];

      windowrule = [
        # window rules to prevent screen from turning off
        "idleinhibit fullscreen,firefox"
        "idleinhibit fullscreen,mpv"
      ];
    };
  };
}
