{...}: {
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    keymaps = [
      {
        action = "<Esc>";
        key = "jj";
        mode = "i";
        options.desc = "Enter NORMAL mode";
      }
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
        options.desc = "Remove higlight from search";
      }
      {
        action = "<C-\\><C-n>";
        key = "<Esc><Esc>";
        mode = "t";
        options.desc = "Enter NORMAL mode (from TERMINAL mode)";
      }
      {
        action = "<C-w><C-h>";
        key = "<C-h>";
        mode = "n";
        options.desc = "Move window focus (left)";
      }
      {
        action = "<C-w><C-j>";
        key = "<C-j>";
        mode = "n";
        options.desc = "Move window focus (down)";
      }
      {
        action = "<C-w><C-k>";
        key = "<C-k>";
        mode = "n";
        options.desc = "Move window focus (up)";
      }
      {
        action = "<C-w><C-l>";
        key = "<C-l>";
        mode = "n";
        options.desc = "Move window focus (right)";
      }
      # Buffers
      {
        action = ":bprev<CR>";
        key = "<S-h>";
        mode = "n";
        options.desc = "Previous buffer";
      }
      {
        action = ":bnext<CR>";
        key = "<S-l>";
        mode = "n";
        options.desc = "Next buffer";
      }
      {
        action = ":bd<CR>";
        key = "<S-q>";
        mode = "n";
        options.desc = "Close buffer";
      }
    ];
  };
}
