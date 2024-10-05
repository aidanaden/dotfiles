{pkgs, ...}: {
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  environment.systemPackages = with pkgs; [
    fprintd
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    scheherazade-new
    ia-writer-duospace
    meslo-lgs-nf
  ];

  # Add ability to used TouchID for sudo authentication
  system = {
    fprintd = {
      enable = true;
    };
  };
}
