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

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
}
