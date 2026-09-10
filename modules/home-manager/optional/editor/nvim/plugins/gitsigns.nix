{...}: {
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Gitsigns preview_hunk_inline<cr>";
        options.desc = "[G]it [S]how Changes";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>Gitsigns diffthis<cr>";
        options.desc = "[G]it show [D]iff";
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<cr>";
        options.desc = "[G]it [R]eset changes";
      }
      {
        mode = "v";
        key = "<leader>gr";
        action.__raw = ''
          function()
            local first = vim.fn.line("v")
            local last = vim.fn.line(".")

            if first > last then
              first, last = last, first
            end

            require("gitsigns").reset_hunk({ first, last })
          end
        '';
        options.desc = "[G]it [R]eset changes";
      }
    ];
  };
}
