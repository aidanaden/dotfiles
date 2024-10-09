{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    cycle = true;
    package = pkgs.rofi-wayland;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];
    terminal = "kitty";
    theme = "./tokyonight.rasi";
    extraConfig = {
      modi = "drun,filebrowser,run,emoji";
      show-icons = true;
      icon-theme = "Papirus";
      location = 0;
      font = "MesloLGS Nerd Font Mono 11";
      drun-display-format = "{icon} {name}";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
    };
  };
}
