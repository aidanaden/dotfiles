{ pkgs-unstable, ... }:
let
  unstable = pkgs-unstable;
in
{
  home.packages = [
    unstable.google-chrome
  ];
}
