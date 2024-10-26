{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      name = "aidan";
      email = "aidanaden@hotmail.com";
    };
  };
}
