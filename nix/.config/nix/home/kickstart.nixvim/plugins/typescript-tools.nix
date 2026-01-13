{
  programs.nixvim = {
    plugins.typescript-tools = {
      enable = false;

      # Lazy load only for TS/JS files
      lazyLoad = {
        enable = true;
        settings = {
          ft = [
            "typescript"
            "typescriptreact"
            "javascript"
            "javascriptreact"
          ];
        };
      };

      settings = {
        settings = {
          separate_diagnostic_server = true;
          publish_diagnostic_on = "insert_leave";
          expose_as_code_action = "all";
          tsserver_path = null;
          tsserver_plugins = null;
          tsserver_max_memory = "auto";
          tsserver_format_options = null;
          tsserver_file_preferences = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
          };
          tsserver_locale = "en";
          complete_function_calls = false;
          include_completions_with_insert_text = true;
          code_lens = "off";
          disable_member_code_lens = true;
          jsx_close_tag = {
            enable = true;
            filetypes = [
              "javascriptreact"
              "typescriptreact"
            ];
          };
        };
      };
    };
  };
}
