{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  programs.jujutsu = {
    enable = true;
    package = unstable.jujutsu;
    settings = {
      name = "aidan";
      email = "aidanaden@hotmail.com";
    };
  };
}
