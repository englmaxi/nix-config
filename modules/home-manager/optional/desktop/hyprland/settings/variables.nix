{...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      border_size = 3;
      resize_on_border = true;
    };
    decoration = {
      active_opacity = 0.9;
      inactive_opacity = 0.65;
      fullscreen_opacity = 1.0;
      rounding = 10;
      blur = {
        enabled = true;
        size = 8;
        passes = 3;
        popups = true;
      };
    };
  };
}
