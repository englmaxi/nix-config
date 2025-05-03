{config, ...}: {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = with config.lib.stylix.colors; {
      general = {
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          color = "rgb(${base00})";
          blur_size = 6;
          blur_passes = 3;
        }
      ];

      input-field = [
        {
          outer_color = "rgb(${base03})";
          inner_color = "rgb(${base00})";
          font_color = "rgb(${base05})";
          fail_color = "rgb(${base08})";
          check_color = "rgb(${base0A})";
          outline_thickness = 2;
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
        }
      ];
    };
  };
}
