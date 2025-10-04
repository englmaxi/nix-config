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
