{...}: {
  security.polkit.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4"; # Super key
      terminal = "kitty";
      output = {
        "Virtual-1" = {
          mode = "2560x1440@60Hz";
        };
      };
    };
  };
}
