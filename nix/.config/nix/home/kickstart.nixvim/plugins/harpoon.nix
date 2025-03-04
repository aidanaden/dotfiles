{
  programs.nixvim = {
    plugins.harpoon = {
      enable = true;
      keymaps = {
        toggleQuickMenu = "<leader>h";
        navFile = {
          "1" = "<leader>1";
          "2" = "<leader>2";
          "3" = "<leader>3";
          "4" = "<leader>4";
          "5" = "<leader>5";
          "6" = "<leader>6";
        };
        addFile = "<C-a>";
      };
      menu = {
        height = 20;
        width = 80;
      };
    };
  };
}
