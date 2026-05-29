{...}: {
  programs.nixvim.plugins.illuminate = {
    enable = true;
    settings = {
      delay = 200;
      min_count_to_highlight = 2;
      under_cursor = true;
      providers = [
        "lsp"
        "treesitter"
      ];
    };
  };
}
