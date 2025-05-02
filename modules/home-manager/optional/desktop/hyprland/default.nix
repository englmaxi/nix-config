{pkgs, ...}: {
  imports = [
    ./rofi.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;
    systemd.enable = false;
    settings = {
      monitor = [
        "eDP-1,preferred,0x0,1"
        ",preferred,auto,auto,mirror,eDP-1"
      ];
      layerrule = [
        "blur, waybar"
        "ignorezero , waybar"
      ];
      decoration = {
        active_opacity = 0.9;
        inactive_opacity = 0.65;
        fullscreen_opacity = 1.0;
        rounding = 4;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
        };
      };
      input = {
        kb_layout = "de";
        touchpad = {
          natural_scroll = true;
        };
      };
      gestures = {
        workspace_swipe = true;
      };
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      bind =
        [
          "$mod, RETURN, exec, $terminal"
          "$mod, E, exec, $fileManager"
          ", Print, exec, grimblast copy area"
          "$mod, SPACE, exec, rofi -show combi -modes \"calc,combi\" -combi-modes \"drun,run,emoji\""
          
          "$mod, Q, killactive"
          "ALT, F4, killactive"
          
          "$mod, F, fullscreen, 1"
          "$mod SHIFT, F, fullscreen, 0"
          
          "$mod, V, togglefloating,"
          "$mod, J, togglesplit,"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          ", XF86AudioRaiseVolume, exec, pamixer -i 5"
          ", XF86AudioLowerVolume, exec, pamixer -d 5"
          ", XF86AudioMute, exec, pamixer -t"
          
          ", XF86MonBrightnessUp, exec, light -A 5"
          ", XF86MonBrightnessDown, exec, light -U 5"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, Control_L, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, ALT_L, resizewindow"
      ];
    };
  };

  home.packages = with pkgs; [
    nautilus
  ];

  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
  };

  services = {
    dunst = {
      enable = true;
    };
  };
}
