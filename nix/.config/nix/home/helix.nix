{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  # https://mynixos.com/home-manager/options/programs.helix
  programs.helix = {
    enable = true;
    package = pkgs.helix;
    # settings =
    #   {
    #   };
  };
}
