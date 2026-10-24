_: {
  programs.nixvim = {
    plugins.trouble = {
      enable = true;
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>tD";
        action = "<cmd>Trouble diagnostics toggle focus=false<cr>";
        options.desc = "[T]oggle [D]iagnostics (all buffers)";
      }
      {
        mode = "";
        key = "<leader>td";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0 focus=false<cr>";
        options.desc = "[T]oggle [D]iagnostics (current buffer)";
      }
    ];
  };
}
