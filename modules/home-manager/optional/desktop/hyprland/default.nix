{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./settings
    ./tools
  ];

  options.modules.home-manager.optional.desktop.hyprland = with lib; {
    monitors = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    keyMap = mkOption {
      type = types.str;
      default = "de";
    };
  };

  config = let
    cfg = config.modules.home-manager.optional.desktop.hyprland;
  in {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.inputs.hyprland.hyprland;
      systemd.enable = false;
      settings = {
        monitor =
          cfg.monitors
          ++ [
            ", preferred, auto, 1"
          ];
        layerrule = [
          "blur, waybar"
          "ignorezero, waybar"
        ];
        windowrule = [
          "float, class:(clipse)"
          "size 850 700 , class:(clipse)"
          "stayfocused, class:(clipse)"
          "float, class:(^(MEGAsync)$)"
          "noborder, class:(^(MEGAsync)$)"
          "noblur, class:(^(MEGAsync)$)"
          "noshadow, class:(^(MEGAsync)$)"
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
        dwindle = {
          smart_split = true;
        };
        misc = {
          vfr = true;
        };
      };
    };

    stylix.iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
    };
    xdg.mimeApps = {
      defaultApplications = {
        "application/pdf" = "org.gnome.Evince.desktop";
        "image/png" = "qimgv.desktop";
        "image/jpeg" = "qimgv.desktop";
        "text/plain" = "nvim.desktop";
      };
    };
  };
}
