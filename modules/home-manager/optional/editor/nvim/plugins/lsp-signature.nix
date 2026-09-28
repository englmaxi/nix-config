{config,...}: {
  programs.nixvim.plugins.lsp-signature = {
    enable = true;
    settings = {
      hint_prefix = {
        above = "↙ ";
        current = "← ";
        below = "↖ ";
      };
      floating_window = false;
      hint_scheme = "Character";
    };
  };
}
