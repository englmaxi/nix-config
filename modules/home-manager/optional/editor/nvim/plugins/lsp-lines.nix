{...}: {
  programs.nixvim = {
    plugins.lsp-lines = {
      enable = true;
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>tl";
        action.__raw = ''
          require("lsp_lines").toggle
        '';
        options.desc = "[T]oggle [L]SP lines";
      }
    ];
  };
}
