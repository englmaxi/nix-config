_: {
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = ",";

    extraConfigVim = ''
      cabbrev W w
    '';

    keymaps = let
      toList = x:
        if builtins.isList x
        then x
        else [x];

      kmOpts = mode: keys: action: desc: opts:
        builtins.concatMap
        (
          m:
            map (k: {
              mode = m;
              key = k;
              inherit action;
              options =
                {
                  inherit desc;
                  silent = true;
                }
                // opts;
            }) (toList keys)
        )
        (toList mode);

      km = mode: keys: action: desc:
        kmOpts mode keys action desc {};
    in
      # Mode switching
      km "i" "jj" "<Esc>" "Enter NORMAL mode"
      ++ km "n" "<Esc>" "<cmd>nohlsearch<CR>" "Clear search highlights"
      ++ km "t" "<Esc><Esc>" "<C-\\><C-n>" "Enter NORMAL mode"
      # Clipboard
      ++ km "x" "<leader>p" "\"_dP" "Paste without yanking"
      ++ km ["n" "x"] "<leader>x" "\"_d" "Delete without yanking"
      # Window navigation
      ++ km "n" ["<C-h>" "<C-Left>"] "<C-w>h" "Move focus left"
      ++ km "n" ["<C-j>" "<C-Down>"] "<C-w>j" "Move focus down"
      ++ km "n" ["<C-k>" "<C-Up>"] "<C-w>k" "Move focus up"
      ++ km "n" ["<C-l>" "<C-Right>"] "<C-w>l" "Move focus right"
      # Window management
      ++ km "n" "<leader>ws" "<cmd>split<CR>" "Horizontal split"
      ++ km "n" "<leader>wv" "<cmd>vsplit<CR>" "Vertical split"
      ++ km "n" "<leader>wd" "<cmd>close<CR>" "Close window"
      ++ km "n" "<leader>wo" "<cmd>only<CR>" "Close other windows"
      ++ km "n" "<leader>w=" "<C-w>=" "Equalize window sizes"
      # Buffer navigation
      ++ km "n" ["<S-h>" "<S-Left>"] "<cmd>bprevious<CR>" "Previous buffer"
      ++ km "n" ["<S-l>" "<S-Right>"] "<cmd>bnext<CR>" "Next buffer"
      # Buffer management
      ++ km "n" "<leader>bd" "<cmd>bdelete<CR>" "Delete buffer"
      ++ km "n" "<leader>bD" "<cmd>bdelete!<CR>" "Force delete buffer"
      # Quickfix
      ++ km "n" "<leader>qf" "<cmd>cwindow<CR>" "Toggle quickfix list"
      ++ km "n" "<leader>qc" "<cmd>cclose<CR>" "Close quickfix list"
      # Location list
      ++ km "n" "<leader>ll" "<cmd>lwindow<CR>" "Toggle location list"
      ++ km "n" "<leader>lc" "<cmd>lclose<CR>" "Close location list"
      # Move lines
      ++ km "n" ["<A-j>" "<A-Down>"] "<cmd>move .+1<CR>==" "Move line down"
      ++ km "n" ["<A-k>" "<A-Up>"] "<cmd>move .-2<CR>==" "Move line up"
      # Move visual selection
      ++ km "x" ["<A-j>" "<A-Down>"] ":move '>+1<CR>gv=gv" "Move selection down"
      ++ km "x" ["<A-k>" "<A-Up>"] ":move '<-2<CR>gv=gv" "Move selection up"
      # Indentation
      ++ km "x" "<" "<gv" "Indent left and reselect"
      ++ km "x" ">" ">gv" "Indent right and reselect"
      # Blank lines
      ++ km "n" "<leader>o" "<cmd>call append(line('.'), repeat([''], v:count1))<CR>" "Add blank line below"
      ++ km "n" "<leader>O" "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>" "Add blank line above";
  };
}
