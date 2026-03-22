{
  config,
  lib,
  ...
}: let
  inherit (lib) concatLists genList concatStringsSep;

  mod = "SUPER";
  terminal = "kitty";
  fileManager = "kitty -e yazi";
  launcherCmd = concatStringsSep " " [
    "rofi -show combi"
    "-modes \"calc,combi,window\""
    "-combi-modes \"drun,run,nerdy,emoji\""
    # "-show-icons"
    "-display-drun \"\""
    "-display-run \" ❯\""
    "-sidebar-mode"
  ];

  wsBinds =
    concatLists (genList (
        i: let
          ws = i + 1;
        in [
          "$mod,       code:1${toString i}, workspace,       ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      )
      9)
    ++ [
      "ALT_L,      TAB, workspace, m+1"
      "$mod ALT_L, TAB, workspace, empty"
      "$mod,        0,  workspace, empty"
    ];

  appBinds = [
    "$mod,       RETURN, exec, uwsm app -- $terminal"
    "$mod,       E,      exec, uwsm app -- $fileManager"
    "$mod,       SPACE,  exec, uwsm app -- ${launcherCmd}"
    "$mod ALT_L, V,      exec, uwsm app -- kitty --class clipse -e clipse"

    "$mod,       L, exec, loginctl lock-session"
    "$mod SHIFT, L, exec, systemctl suspend-then-hibernate"
    "$mod ALT,   L, exec, systemctl hibernate"
  ];

  screenshotDir = "${config.xdg.userDirs.pictures}/screenshots";
  screenshotBinds = [
    ",           PRINT, exec, uwsm app -- hyprshot -o ${screenshotDir} -zm region"
    "$mod,       PRINT, exec, uwsm app -- hyprshot -o ${screenshotDir} -zm window"
    "$mod SHIFT, PRINT, exec, uwsm app -- hyprshot -o ${screenshotDir} -zm output"
  ];

  windowBinds = [
    "$mod, C,  killactive"
    "ALT,  F4, forcekillactive"

    "$mod,       F, fullscreen, 1"
    "$mod SHIFT, F, fullscreen, 0"

    "$mod, V, togglefloating"
    "$mod, P, pin"
    "$mod, S, layoutmsg, togglesplit"

    "$mod,         G,     togglegroup"
    "$mod Control, left,  changegroupactive, l"
    "$mod Control, right, changegroupactive, r"

    "$mod, left,  movefocus, l"
    "$mod, right, movefocus, r"
    "$mod, up,    movefocus, u"
    "$mod, down,  movefocus, d"

    "$mod SHIFT, left,  swapwindow, l"
    "$mod SHIFT, right, swapwindow, r"
    "$mod SHIFT, up,    swapwindow, u"
    "$mod SHIFT, down,  swapwindow, d"

    "$mod,       N, togglespecialworkspace, scratchpad"
    "$mod SHIFT, N, movetoworkspace,        special:scratchpad"

    "$mod, P, togglespecialworkspace, spotify"
  ];

  mediaBinds = [
    ", XF86AudioRaiseVolume, exec, pamixer -i 5"
    ", XF86AudioLowerVolume, exec, pamixer -d 5"
    ", XF86AudioMute,        exec, pamixer -t"
    ", XF86AudioPlay,        exec, playerctl play-pause"
    ", XF86AudioPause,       exec, playerctl play-pause"
    ", XF86AudioNext,        exec, playerctl next"
    ", XF86AudioPrev,        exec, playerctl previous"

    ", XF86MonBrightnessUp,   exec, brightnessctl set 5%-"
    ", XF86MonBrightnessDown, exec, brightnessctl set +5%"
  ];

  mouseBinds = [
    "$mod, mouse:272, movewindow"
    "$mod, Control_L, movewindow"
    "$mod, mouse:273, resizewindow"
    "$mod, ALT_L,     resizewindow"
  ];

  gestures = [
    "3, horizontal, workspace"
    "3, down,       special,    scratchpad"
    "3, up,         special,    scratchpad"
  ];

  cfg = config.modules.home-manager.optional.desktop.hyprland;
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = mod;
    "$terminal" = terminal;
    "$fileManager" = fileManager;

    bind =
      appBinds
      ++ screenshotBinds
      ++ windowBinds
      ++ wsBinds;

    bindel = mediaBinds;
    bindm = mouseBinds;
    gesture = gestures;

    input = {
      kb_layout = cfg.keyMap;
      touchpad.natural_scroll = true;
    };
  };
}
