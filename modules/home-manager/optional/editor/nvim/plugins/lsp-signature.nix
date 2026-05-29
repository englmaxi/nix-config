{...}: {
  programs.nixvim.plugins.lsp-signature = {
    enable = true;
    settings.hint_prefix = {
      above = "↙ ";
      current = "← ";
      below = "↖ ";
    };
    settings.floating_window = false;
  };
}
