{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [pkgs.inputs.hyprland-plugins.hyprbars];
    settings = {
      plugin.hyprbars = let
        c = config.lib.stylix.colors;
      in {
        enabled = true;
        bar_height = 30;
        bar_padding = 10;
        bar_button_padding = 5;
        bar_blur = true;
        bar_title_enabled = false;
        bar_precedence_over_border = true;
        bar_part_of_window = true;
        bar_color = "rgb(${c.base00})";

        hyprbars-button = [
          "rgb(${c.base0F}), 13, , hyprctl dispatch killactive"
          "rgb(${c.base0A}), 13, , hyprctl dispatch togglegroup"
          "rgb(${c.base0B}), 13, , hyprctl dispatch movetoworkspacesilent \"special:hidden\""
        ];

        on_double_click = "hyprctl dispatch fullscreen 1";
      };
      windowrule = [
        "hyprbars:no_bar 1, match:workspace s[true]"
        "hyprbars:no_bar 1, match:float 1, match:pin 1"
      ];
    };
  };
}
