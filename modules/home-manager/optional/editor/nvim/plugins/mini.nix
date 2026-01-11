{...}: {
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      ai.nlines.n_lines = 500;
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
      move = {};
      pairs = {};
    };
  };
}
