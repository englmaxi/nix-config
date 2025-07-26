{...}: {
  programs.nixvim.plugins.yazi = {
    enable = true;
  };
  programs.nixvim.keymaps = [
    {
      mode = "";
      key = "<leader>--";
      action = "<cmd>Yazi toggle<CR>";
      options.desc = "Open File Manager";
    }
    {
      mode = "";
      key = "<leader>-.";
      action = "<cmd>Yazi<CR>";
      options.desc = "Open File Manager in current directory";
    }
  ];
}
