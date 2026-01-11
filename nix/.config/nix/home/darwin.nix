{ ... }:
{
  imports = [
    ./default.nix
    ./aerospace.nix
    ./stylix.nix
    ./chrome.nix
    ./pam_reattach.nix
    ./darwin-stats.nix
  ];

  # Disable Linux-only stylix targets on Darwin
  stylix.targets.waybar.enable = false;
}
