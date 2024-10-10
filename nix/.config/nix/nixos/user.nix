{
  user,
  hostname,
  pkgs,
  ...
}: {
  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
    isNormalUser = true;
    description = user;
    extraGroups = ["networkmanager" "wheel"];
  };

  networking = {
    hostName = hostname;
  };

  nix.settings.allowed-users = [user];
}
