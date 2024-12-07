{ pkgs, ... }:
{
  # https://mynixos.com/home-manager/options/programs.helix
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    # settings =
    #   {
    #   };
  };
}
