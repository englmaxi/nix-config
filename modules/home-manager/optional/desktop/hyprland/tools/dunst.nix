{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        corner_radius = 10;
        offset = "(20, 20)";
        dmenu = "rofi -dmenu -p dunst -no-fixed-num-lines";
        mouse_right_click = "context";
      };
    };
  };
}
