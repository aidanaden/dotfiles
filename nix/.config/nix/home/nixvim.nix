{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}