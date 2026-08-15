{...}: {
  wayland.windowManager.hyprland.settings = {
    layer_rule = [
      {
        match.namespace = "waybar";
        blur = true;
        ignore_alpha = 0;
      }
      {
        match.namespace = "rofi";
        blur = true;
        ignore_alpha = 0;
        dim_around = true;
      }
    ];

    window_rule = [
      {
        match.class = ".*";
        suppress_event = "maximize";
      }
      {
        match.float = true;
        max_size = [
          1200
          800
        ];
        center = true;
      }
      {
        match.class = "clipse";
        float = true;
        size = [
          850
          700
        ];
        stay_focused = true;
      }
      {
        match.class = "^(Gimp)$";
        opacity = "1.0 override";
      }
      {
        match.title = "^(Picture-in-Picture)$";
        float = true;
        pin = true;
        size = [
          270
          204
        ];
        move = "100%-270 100%-204";
        border_size = 0;
        no_initial_focus = true;
        opacity = "1.0 override 1.0 override";
      }
      {
        match.class = "^(org.pulseaudio.pavucontrol)$";
        float = true;
        size = [
          1200
          800
        ];
        stay_focused = true;
        dim_around = true;
        center = true;
      }
      {
        match.content = "video";
        opacity = "1.0 override 1.0 override";
      }
      {
        match.title = ".*(YouTube|Twitch|Netflix|Prime Video|Picture-in-Picture).*";
        opacity = "1.0 override 1.0 override";
      }
    ];

    workspace_rule = [
      {
        workspace = "s[true]";
        gaps_out = 80;
      }
      {
        workspace = "s[true]m[DP-2]";
        gaps_out = {
          top = 80;
          bottom = 80;
          left = 600;
          right = 600;
        };
      }
      {
        workspace = "special:scratchpad";
        on_created_empty = "kitty";
      }
      {
        workspace = "special:spotify";
        on_created_empty = "spotify";
      }
      {
        workspace = "w[tv1]s[false]m[DP-2]";
        gaps_out = {
          top = 20;
          bottom = 20;
          left = 520;
          right = 520;
        };
      }
    ];
  };
}
