{config, ...}: {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = let
      c = config.lib.stylix.colors;
    in {
      general = {
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          color = "rgb(${c.base00})";
          blur_size = 6;
          blur_passes = 3;
        }
      ];

      input-field = [
        {
          outer_color = "rgb(${c.base03})";
          inner_color = "rgb(${c.base00})";
          font_color = "rgb(${c.base05})";
          fail_color = "rgb(${c.base08})";
          check_color = "rgb(${c.base0A})";
          outline_thickness = 2;
          size = "200, 50";
          position = "0, -120";
          monitor = "";
          dots_center = true;
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M") </big></b>"'';
          color = "rgb(${c.base05})";
          font_size = 96;
          position = "0, 200";
          halign = "center";
          valign = "center";
          monitor = "";
        }
      ];
    };
  };
}
