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
        mode = "";
        key = "<leader>oa";
        action = "<cmd>Lspsaga code_action<cr>";
        options.desc = "[O]pen code [A]ctions";
      }
    ];
  };
}
