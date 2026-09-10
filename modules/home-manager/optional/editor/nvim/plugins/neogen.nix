{...}: {
  programs.nixvim = {
    plugins.neogen = {
      enable = true;
      settings = {
        snippet_engine = "luasnip";
      };
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>dg";
        action = "<cmd>Neogen<cr>";
        options.desc = "[D]ocumentation [G]enerate";
      }
    ];
  };
}
