{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [pkgs.inputs.hyprland-plugins.hyprbars];
    settings = let
      c = config.lib.stylix.colors;
    in {
      config.plugin.hyprbars = {
        enabled = true;
        bar_height = 30;
        bar_padding = 10;
        bar_button_padding = 5;
        bar_blur = true;
        bar_title_enabled = false;
        bar_precedence_over_border = true;
        bar_part_of_window = true;
        bar_color = "rgb(${c.base00})";
      };
      "plugin.hyprbars.add_button" = [
        {
          bg_color = "rgb(${c.base0F})";
          fg_color = "rgb(${c.base0F})";
          size = 13;
          icon = "";
          action = "hyprctl dispatch 'hl.dsp.window.close()'";
        }
        {
          bg_color = "rgb(${c.base0A})";
          fg_color = "rgb(${c.base0A})";
          size = 13;
          icon = "";
          action = "hyprctl dispatch 'hl.dsp.group.toggle()'";
        }
        {
          bg_color = "rgb(${c.base0B})";
          fg_color = "rgb(${c.base0B})";
          size = 13;
          icon = "";
          action = "hyprctl dispatch 'hl.dsp.window.fullscreen({mode = \"maximized\"})'";
        }
      ];
      window_rule = [
        {
          match.workspace = "s[true]";
          "hyprbars:no_bar" = true;
        }
        {
          match = {
            float = true;
            pin = true;
          };
          "hyprbars:no_bar" = true;
        }
      ];
    };
  };
}
