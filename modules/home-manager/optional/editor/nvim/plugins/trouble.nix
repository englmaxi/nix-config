{...}: {
  programs.nixvim = {
    plugins.trouble = {
      enable = true;
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>td";
        action = "<cmd>Trouble diagnostics toggle focus=false<cr>";
        options.desc = "[T]oggle [D]iagnostics";
      }
    ];
  };
}
