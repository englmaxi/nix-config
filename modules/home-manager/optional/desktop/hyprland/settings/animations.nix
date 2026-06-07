{...}: {
  wayland.windowManager.hyprland.settings = {
    animation = [
      {
        leaf = "specialWorkspace";
        enabled = true;
        speed = 6.0;
        bezier = "default";
        style = "slidefadevert";
      }
    ];
  };
}
