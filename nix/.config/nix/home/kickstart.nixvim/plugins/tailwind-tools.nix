{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ tailwind-tools-nvim ];
    extraConfigLua = ''
      require("tailwind-tools").setup({
        -- your configuration
      })  
    '';
  };
}
