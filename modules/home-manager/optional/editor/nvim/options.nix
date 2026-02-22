{...}: {
  programs.nixvim = {
    globals.have_nerd_font = true;
    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;
      wrap = false;
      breakindent = true;
      scrolloff = 10;
      sidescrolloff = 10;

      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = true;
      autoindent = true;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      colorcolumn = "80";
 
      undodir.__raw = "vim.fs.normalize('~/.undodir')";
      undofile = true;
      backup = false;
      writebackup = false;
      autowrite = false;
      
      mouse = "a";
      showmode = false;
      clipboard = "unnamedplus";
      
      updatetime = 250;
      timeoutlen = 300;
      ttimeoutlen = 0;

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

      confirm = true;
    };
  };
}
