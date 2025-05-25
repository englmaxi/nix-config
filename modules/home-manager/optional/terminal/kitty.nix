{
  config,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    font.size = 12;
    font.name = lib.mkDefault "FiraCode Nerd Font Mono";
    extraConfig = ''
      window_padding_width 8
      map kitty_mod+up resize_window taller
      map kitty_mod+down resize_window shorter 3
      map kitty_mod+t new_tab_with_cwd
      map kitty_mod+enter new_window_with_cwd
      enable_audio_bell no
      cursor_trail 1
      # background_opacity ${builtins.toString config.stylix.opacity.desktop}
    '';
  };
}
