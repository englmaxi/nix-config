{...}:{
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      ai.nlines.n_lines = 500;
      surround = {};
      move = {};
      pairs = {};
    };
  };
}
