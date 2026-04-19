{...}: {
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;
      ui.codeAction = "󰌵";
      lightbulb.sign = false;
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>oa";
        action = "<cmd>Lspsaga code_action<cr>";
        options.desc = "[O]pen code [A]ctions";
      }
    ];
  };
}
