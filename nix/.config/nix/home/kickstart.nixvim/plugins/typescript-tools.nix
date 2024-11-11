{
  programs.nixvim = {
    plugins.typescript-tools = {
      enable = true;
      settings = {
        separateDiagnosticServer = true;
        publishDiagnosticOn = "insert_leave";
        exposeAsCodeAction = null;
        tsserverPath = null;
        tsserverPlugins = null;
        tsserverMaxMemory = "auto";
        tsserverFormatOptions = null;
        tsserverFilePreferences = {
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
        tsserverLocale = "en";
        completeFunctionCalls = false;
        includeCompletionsWithInsertText = true;
        codeLens = "off";
        disableMemberCodeLens = true;
        jsxCloseTag = {
          enable = true;
          filetypes = [
            "javascriptreact"
            "typescriptreact"
          ];
        };
      };
    };
  };
}
