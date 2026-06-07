{...}: {
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        border_size = 3;
        resize_on_border = true;
      };
      decoration = {
        active_opacity = 0.9;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;
        rounding = 10;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          popups = false;
        };
      };
      dwindle = {
        smart_split = false;
        preserve_split = true;
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      group.groupbar = {
        font_size = 16;
        rounding = 2;
      };
    };
  };
}
