{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";

    fonts = {
      sizes = {
        desktop = 12;
        popups = 12;
        terminal = 12;
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
