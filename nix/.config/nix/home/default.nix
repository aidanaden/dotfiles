{terminal, ...}: {
  imports =
    [
      ./zsh
      ./tmux
      ./bat
      ./git.nix
      ./btop.nix
      ./yazi.nix
      ./spotify.nix
      ./programs.nix
      ./stylix.nix
      ./kickstart.nixvim/nixvim.nix
    ]
    ++ (
      if terminal == "alacritty"
      then [./alacritty.nix]
      else [./kitty.nix]
    );
}
