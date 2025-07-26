{...}: {
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      ts_ls.enable = true;
      lua_ls.enable = true;
      pyright.enable = true;
      clangd.enable = true;
      nixd.enable = true;
      rust_analyzer = {
        enable = true;
        installRustc = false;
        installCargo = false;
      };
    };
    postConfig = ''
      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "󰋼",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        }
      }
    '';
  };
}
