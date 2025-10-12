{
  config,
  lib,
  ...
}: let
  inherit (lib) concatLists genList;

  mod = "SUPER";
  terminal = "kitty";
  fileManager = "kitty -e yazi";

  wsBinds = concatLists (genList (
      i: let
        ws = i + 1;
      in [
        "$mod,       code:1${toString i}, workspace,       ${toString ws}"
        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
      ]
    )
    9);

  appBinds = [
    "$mod,       RETURN, exec, $terminal"
    "$mod,       E,      exec, $fileManager"
    "$mod,       SPACE,  exec, rofi -show combi -modes \"calc,combi\" -combi-modes \"drun,run,emoji\""
    "$mod ALT_L, V,      exec, kitty --class clipse -e clipse"
  ];

  screenshotDir = "${config.xdg.userDirs.pictures}/screenshots";
  screenshotBinds = [
    ",           PRINT, exec, hyprshot -o ${screenshotDir} -zm region"
    "$mod,       PRINT, exec, hyprshot -o ${screenshotDir} -zm window"
    "$mod SHIFT, PRINT, exec, hyprshot -o ${screenshotDir} -zm output"
  ];

  windowBinds = [
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
    "$mod SHIFT, down,  swapwindow, d"

    "$mod, S, togglespecialworkspace, hidden"
    "$mod, S, movetoworkspace,        +0"
    "$mod, S, togglespecialworkspace, hidden"
    "$mod, S, movetoworkspace,        special:hidden"
    "$mod, S, togglespecialworkspace, hidden"

    "$mod,       N, togglespecialworkspace, scratchpad"
    "$mod SHIFT, N, movetoworkspace,        special:scratchpad"
  ];

  mediaBinds = [
    ", XF86AudioRaiseVolume, exec, pamixer -i 5"
    ", XF86AudioLowerVolume, exec, pamixer -d 5"
    ", XF86AudioMute,        exec, pamixer -t"

    ", XF86MonBrightnessUp,   exec, light -A 5"
    ", XF86MonBrightnessDown, exec, light -U 5"
  ];

  mouseBinds = [
    "$mod, mouse:272, movewindow"
    "$mod, Control_L, movewindow"
    "$mod, mouse:273, resizewindow"
    "$mod, ALT_L,     resizewindow"
  ];

  gestures = [
    "3, horizontal, workspace"
    "3, up,         fullscreen, maximize"
    "3, down,       special,    scratchpad"
    "4, down,       close"
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
