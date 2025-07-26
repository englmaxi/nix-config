{...}:{
  programs.nixvim.plugins.lsp-signature = {
    enable = true;
    settings.hint_prefix = " ";
    settings.floating_window = false;
  };
}