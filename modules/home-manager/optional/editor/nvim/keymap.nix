{...}: {
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    keymaps = let
      toList = x:
        if builtins.isList x
        then x
        else [x];

      km = mode: keys: action: desc: let
        modes = toList mode;
        ks = toList keys;
      in
        builtins.concatMap (
          m:
            map (k: {
              mode = m;
              key = k;
              action = action;
              options.desc = desc;
            })
            ks
        )
        modes;
    in
      []
      ++ km "i" "jj" "<Esc>" "Enter NORMAL mode"
      ++ km "n" "<Esc>" "<cmd>nohlsearch<CR>" "Remove higlight from search"
      ++ km "t" "<Esc><Esc>" "<C-\\><C-n>" "Enter NORMAL mode (from TERMINAL mode)"
      ++ km "x" "<leader>p" "\"_dP" "[P]aste without yanking"
      ++ km ["n" "v"] "<leader>x" "\"_d" "[X] Delete without yanking"
      # window navigation
      ++ km "n" ["<C-h>" "<C-Left>"] "<C-w><C-h>" "Move window focus (left)"
      ++ km "n" ["<C-j>" "<C-Down>"] "<C-w><C-j>" "Move window focus (down)"
      ++ km "n" ["<C-k>" "<C-Up>"] "<C-w><C-k>" "Move window focus (up)"
      ++ km "n" ["<C-l>" "<C-Right>"] "<C-w><C-l>" "Move window focus (right)"
      # buffers
      ++ km "n" ["<S-h>" "<S-Left>"] ":bprev<CR>" "Previous buffer"
      ++ km "n" ["<S-l>" "<S-Right>"] ":bnext<CR>" "Next buffer"
      ++ km "n" "<S-q>" ":bd<CR>" "Close buffer"
      ++ km "n" "<leader>bsv" ":vsplit<CR>" "[B]uffer [Split] [V]ertically"
      ++ km "n" "<leader>bsh" ":split<CR>" "[B]uffer [Split] [H]orizontally"
      # move line (normal)
      ++ km "n" ["<A-j>" "<A-Down>"] ":m .+1<CR>==" "Move line down"
      ++ km "n" ["<A-k>" "<A-Up>"] ":m .-2<CR>==" "Move line up"
      # move selection (visual)
      ++ km "v" ["<A-j>" "<A-Down>"] ":m '>+1<CR>gv=gv" "Move line down"
      ++ km "v" ["<A-k>" "<A-Up>"] ":m '<-2<CR>gv=gv" "Move line up"
      # indent
      ++ km "v" "<" "<gv" "Indent left and reselect"
      ++ km "v" ">" ">gv" "Indent right and reselect";
  };
}
