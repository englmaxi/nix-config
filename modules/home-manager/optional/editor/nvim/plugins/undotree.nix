{...}: {
  programs.nixvim = {
    plugins.undotree = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>tu";
        action = "<cmd>:UndotreeToggle<cr>";
        options.desc = "[T]oggle [U]ndotree";
      }
    ];
  };
}

