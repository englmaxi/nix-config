{...}: {
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;
      settings = {
        ui.code_action = " 󰌵";
        lightbulb.sign = false;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>da";
        action = "<cmd>Lspsaga code_action<cr>";
        options.desc = "[D]iagnostics: Open Code [A]ctions";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<cr>";
        options.desc = "Hover Documentation";
      }
      {
        mode = "n";
        key = "<leader>df";
        action = "<cmd>Lspsaga finder<cr>";
        options.desc = "[D]iagnostics: [F]inder";
      }
      {
        mode = "n";
        key = "<leader>dn";
        action = "<cmd>Lspsaga diagnostic_jump_next<cr>";
        options.desc = "[D]iagnostics: [N]ext Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>dd";
        action = "<cmd>Lspsaga peek_definition<cr>";
        options.desc = "[D]iagnostics: [D]efenition";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>Lspsaga rename<cr>";
        options.desc = "[D]iagnostics: [R]ename";
      }
      {
        mode = "n";
        key = "<leader>dhi";
        action = "<cmd>Lspsaga incoming_calls<cr>";
        options.desc = "[D]iagnostics: [H]ierarchy [I]ncoming";
      }
      {
        mode = "n";
        key = "<leader>dho";
        action = "<cmd>Lspsaga outgoing_calls<cr>";
        options.desc = "[D]iagnostics: [H]ierarchy [O]utgoing";
      }
    ];
  };
}
