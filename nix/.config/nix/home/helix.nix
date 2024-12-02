{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    packages = pkgs.evil-helix;
    # settings =
    #   {
    #   };
  };
}
