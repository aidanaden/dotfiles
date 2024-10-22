{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  programs.nixvim = {
    extraPlugins = with unstable.vimPlugins; [ tailwind-tools-nvim ];
    extraConfigLua = ''
      require("tailwind-tools").setup({
        -- your configuration
      })  
    '';
  };
}
