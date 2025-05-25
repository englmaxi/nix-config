{...}: {
  programs.nixvim = {
    globals.have_nerd_font = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;

      smartindent = true;
      undofile = true;

      mouse = "a";
      showmode = false;
      clipboard = "unnamedplus";
      breakindent = true;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      colorcolumn = "80";

      updatetime = 250;
      timeoutlen = 300;

      splitright = true;
      splitbelow = true;

      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        space = "·";
        nbsp = "␣";
      };

      inccommand = "split";

      cursorline = true;
      scrolloff = 10;

      confirm = true;
    };
  };
}
