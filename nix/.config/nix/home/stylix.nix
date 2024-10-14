{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";
    image = ../wallpapers/tokyodark/wallpaper1.png;

    targets = {
      kitty = {
        enable = true;
        variant256Colors = true;
      };
      waybar = {
        enable = true;
        enableCenterBackColors = false;
        enableLeftBackColors = false;
        enableRightBackColors = false;
      };
      rofi = {
        enable = true;
      };
      hyprland = {
        enable = true;
      };
    };

    opacity = {
      desktop = 1.0;
      popups = 1.0;
      applications = 1.0;
      terminal = 1.0;
    };

    fonts = {
      sizes = {
        desktop = 12;
        popups = 12;
        terminal = 11;
        applications = 12;
      };
      serif = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS Nerd Font Mono";
      };
      monospace = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS Nerd Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
