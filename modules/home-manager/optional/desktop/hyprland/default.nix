{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
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
        "ignorezero, waybar"
      ];
      windowrule = [
        "float, class:(clipse)"
        "size 850 700 , class:(clipse)"
        "stayfocused, class:(clipse)"
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
      bind = let
        screenshotDir = "${config.xdg.userDirs.pictures}/screenshots";
      in
        [
          "$mod, RETURN, exec, $terminal"
          "$mod, E,      exec, $fileManager"
          "$mod, SPACE,  exec, rofi -show combi -modes \"calc,combi\" -combi-modes \"drun,run,emoji\""

          ",           PRINT, exec, hyprshot -o ${screenshotDir} -zm region"
          "$mod,       PRINT, exec, hyprshot -o ${screenshotDir} -zm window"
          "$mod SHIFT, PRINT, exec, hyprshot -o ${screenshotDir} -zm output"

          "$mod, Q,  killactive"
          "ALT,  F4, forcekillactive"

          "$mod,       F, fullscreen, 1"
          "$mod SHIFT, F, fullscreen, 0"

          "$mod, V, togglefloating,"
          "$mod, P, pin"

          "$mod, left,  movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up,    movefocus, u"
          "$mod, down,  movefocus, d"
          "$mod SHIFT, left,  swapwindow, l"
          "$mod SHIFT, right, swapwindow, r"
          "$mod SHIFT, up,    swapwindow, u"
          "$mod SFIFT, down,  swapwindow, d"

          "$mod ALT_L, V, exec, kitty --class clipse -e clipse"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod,       code:1${toString i}, workspace,       ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      bindel = [
        # repeat + locked
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute,        exec, pamixer -t"

        ", XF86MonBrightnessUp,   exec, light -A 5"
        ", XF86MonBrightnessDown, exec, light -U 5"
      ];
      bindm = [
        # mouse
        "$mod, mouse:272, movewindow"
        "$mod, Control_L, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, ALT_L,     resizewindow"
      ];
      misc = {
        vfr = true;
      };
    };
  };

  home.packages = with pkgs; [
    hyprshot
    nautilus
    qimgv
    evince
  ];

  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
  };

  services = {
    clipse = {
      enable = true;
      imageDisplay.type = "kitty";
    };
    dunst.enable = true;
    blueman-applet.enable = true;
    udiskie.enable = true;
  };

  xdg.mimeApps = {
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "image/png" = "qimgv.desktop";
      "image/jpeg" = "qimgv.desktop";
      "text/plain" = "nvim.desktop";
    };
  };
}
