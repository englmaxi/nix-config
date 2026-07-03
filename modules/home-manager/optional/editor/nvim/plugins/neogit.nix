{...}: {
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>gg";
        action = "<cmd>Neogit<cr>";
        options.desc = "Show Neo[G]it UI";
      }
    ];
  };
}
