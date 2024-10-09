{pkgs, ...}: {
  home.packages = with pkgs; [
    ktailctl
  ];
}
