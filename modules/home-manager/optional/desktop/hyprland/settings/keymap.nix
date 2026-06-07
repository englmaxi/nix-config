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
    "-modes \\\"calc,combi,window\\\""
    "-combi-modes \\\"drun,run,nerdy,emoji\\\""
    # "-show-icons"
    "-display-drun \\\"\\\""
    "-display-run \\\" ❯\\\""
    "-sidebar-mode"
  ];

  bind = {
    withMod ? null,
    withoutMod ? null,
    cmd,
    flags ? null,
  }: let
    keys =
      if withMod != null
      then
        lib.generators.mkLuaInline ''
          mod .. " + ${withMod}"
        ''
      else withoutMod;
    exec = lib.generators.mkLuaInline cmd;
  in {
    _args = [keys exec] ++ lib.optional (flags != null) flags;
  };

  wsBinds =
    concatLists (genList (
        i: let
          ws = i + 1;
        in [
          (bind {
            withMod = toString ws;
            cmd = ''hl.dsp.focus({workspace = "${toString ws}"})'';
          })
          (bind {
            withMod = "SHIFT + ${toString ws}";
            cmd = ''hl.dsp.window.move({workspace = "${toString ws}"})'';
          })
        ]
      )
      9)
    ++ [
      (bind {
        withoutMod = "ALT_L + TAB";
        cmd = ''hl.dsp.focus({workspace = "m+1"})'';
      })
      (bind {
        withMod = "ALT_L + TAB";
        cmd = ''hl.dsp.focus({workspace = "empty"})'';
      })
      (bind {
        withMod = "0";
        cmd = ''hl.dsp.focus({workspace = "empty"})'';
      })
    ];

  appBinds = [
    (bind {
      withMod = "RETURN";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- " .. terminal)'';
    })
    (bind {
      withMod = "E";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- " .. fileManager)'';
    })
    (bind {
      withMod = "SPACE";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- ${launcherCmd}")'';
    })
    (bind {
      withMod = "ALT_L + V";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- kitty --class clipse -e clipse")'';
    })

    (bind {
      withMod = "L";
      cmd = ''hl.dsp.exec_cmd("loginctl lock-session")'';
    })
    (bind {
      withMod = "SHIFT + L";
      cmd = ''hl.dsp.exec_cmd("systemctl suspend-then-hibernate")'';
    })
    (bind {
      withMod = "ALT + L";
      cmd = ''hl.dsp.exec_cmd("systemctl hibernate")'';
    })
  ];

  screenshotDir = "${config.xdg.userDirs.pictures}/screenshots";
  screenshotBinds = [
    (bind {
      withoutMod = "PRINT";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- hyprshot -o ${screenshotDir} -zm region")'';
    })
    (bind {
      withMod = "PRINT";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- hyprshot -o ${screenshotDir} -zm window")'';
    })
    (bind {
      withMod = "SHIFT + PRINT";
      cmd = ''hl.dsp.exec_cmd("uwsm app -- hyprshot -o ${screenshotDir} -zm output")'';
    })
  ];

  windowBinds = [
    (bind {
      withMod = "C";
      cmd = "hl.dsp.window.close()";
    })
    (bind {
      withoutMod = "ALT + F4";
      cmd = "hl.dsp.window.kill()";
    })

    (bind {
      withMod = "F";
      cmd = ''hl.dsp.window.fullscreen({mode = "maximized"})'';
    })
    (bind {
      withMod = "SHIFT + F";
      cmd = ''hl.dsp.window.fullscreen({mode = "fullscreen"})'';
    })

    (bind {
      withMod = "V";
      cmd = "hl.dsp.window.float()";
    })
    (bind {
      withMod = "P";
      cmd = "hl.dsp.window.pin()";
    })
    (bind {
      withMod = "S";
      cmd = ''hl.dsp.layout("togglesplit")'';
    })

    (bind {
      withMod = "G";
      cmd = "hl.dsp.group.toggle()";
    })
    (bind {
      withMod = "CTRL + LEFT";
      cmd = "hl.dsp.group.next()";
    })
    (bind {
      withMod = "CTRL + RIGHT";
      cmd = "hl.dsp.group.prev()";
    })

    (bind {
      withMod = "LEFT";
      cmd = ''hl.dsp.focus({direction = "l"})'';
    })
    (bind {
      withMod = "RIGHT";
      cmd = ''hl.dsp.focus({direction = "r"})'';
    })
    (bind {
      withMod = "UP";
      cmd = ''hl.dsp.focus({direction = "u"})'';
    })
    (bind {
      withMod = "DOWN";
      cmd = ''hl.dsp.focus({direction = "d"})'';
    })

    (bind {
      withMod = "SHIFT + LEFT";
      cmd = ''hl.dsp.window.swap({direction = "l"})'';
    })
    (bind {
      withMod = "SHIFT + RIGHT";
      cmd = ''hl.dsp.window.swap({direction = "r"})'';
    })
    (bind {
      withMod = "SHIFT + UP";
      cmd = ''hl.dsp.window.swap({direction = "u"})'';
    })
    (bind {
      withMod = "SHIFT + DOWN";
      cmd = ''hl.dsp.window.swap({direction = "d"})'';
    })

    (bind {
      withMod = "N";
      cmd = ''hl.dsp.workspace.toggle_special("scratchpad")'';
    })
    (bind {
      withMod = "SHIFT + N";
      cmd = ''hl.dsp.window.move({workspace = "special:scratchpad"})'';
    })

    (bind {
      withMod = "P";
      cmd = ''hl.dsp.workspace.toggle_special("spotify")'';
    })
  ];

  mediaBinds = let
    addFlags = attrs:
      attrs
      // {
        flags = {
          locked = true;
          repeating = true;
        };
      };
  in
    map (attrs: bind (addFlags attrs)) [
      {
        withoutMod = "XF86AudioRaiseVolume";
        cmd = ''hl.dsp.exec_cmd("pamixer -i 5")'';
      }
      {
        withoutMod = "XF86AudioLowerVolume";
        cmd = ''hl.dsp.exec_cmd("pamixer -d 5")'';
      }
      {
        withoutMod = "XF86AudioMute";
        cmd = ''hl.dsp.exec_cmd("pamixer -t")'';
      }
      {
        withoutMod = "XF86AudioPlay";
        cmd = ''hl.dsp.exec_cmd("playerctl play-pause")'';
      }
      {
        withoutMod = "XF86AudioPause";
        cmd = ''hl.dsp.exec_cmd("playerctl play-pause")'';
      }
      {
        withoutMod = "XF86AudioNext";
        cmd = ''hl.dsp.exec_cmd("playerctl next")'';
      }
      {
        withoutMod = "XF86AudioPrev";
        cmd = ''hl.dsp.exec_cmd("playerctl previous")'';
      }

      {
        withoutMod = "XF86MonBrightnessUp";
        cmd = ''hl.dsp.exec_cmd("brightnessctl set 5%-")'';
      }
      {
        withoutMod = "XF86MonBrightnessDown";
        cmd = ''hl.dsp.exec_cmd("brightnessctl set +5%")'';
      }
    ];

  mouseBinds = let
    addFlags = attrs:
      attrs
      // {
        flags = {
          mouse = true;
        };
      };
  in
    map (attrs: bind (addFlags attrs)) [
      {
        withMod = "mouse:272";
        cmd = "hl.dsp.window.drag()";
      }
      {
        withMod = "CTRL";
        cmd = "hl.dsp.window.drag()";
      }
      {
        withMod = "mouse:273";
        cmd = "hl.dsp.window.resize()";
      }
      {
        withMod = "ALT_L";
        cmd = "hl.dsp.window.resize()";
      }
    ];

  gestures = [
    {
      fingers = 3;
      direction = "horizontal";
      action = "workspace";
    }
    {
      fingers = 3;
      direction = "down";
      action = "special";
      workspace_name = "scratchpad";
    }
    {
      fingers = 3;
      direction = "up";
      action = "special";
      workspace_name = "scratchpad";
    }
  ];

  cfg = config.modules.home-manager.optional.desktop.hyprland;
in {
  wayland.windowManager.hyprland.settings = {
    mod._var = mod;
    terminal._var = terminal;
    fileManager._var = fileManager;

    bind =
      appBinds
      ++ screenshotBinds
      ++ windowBinds
      ++ wsBinds
      ++ mediaBinds
      ++ mouseBinds;

    gesture = gestures;

    config.input = {
      kb_layout = cfg.keyMap;
      touchpad.natural_scroll = true;
    };
  };
}
