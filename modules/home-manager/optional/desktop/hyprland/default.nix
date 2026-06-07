{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./settings
    ./tools
    # ./plugins
  ];

  options.modules.home-manager.optional.desktop.hyprland = with lib; {
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          output = mkOption {
            type = types.str;
            description = "e.g 'DP-1'";
          };
          mode = mkOption {
            type = types.str;
            default = "preferred";
            description = "e.g. '1920x1080@144'";
          };
          position = mkOption {
            type = types.str;
            default = "0x0";
            description = "e.g. '1920x0'";
          };
          scale = mkOption {
            type = types.int;
            default = 1;
            description = "e.g. '1'";
          };
          transform = mkOption {
            type = types.int;
            default = 0;
            description = "Rotation/flip transform (0–7)";
          };
        };
      });
      default = [];
    };
    mainMonitor = mkOption {
      type = types.str;
      description = "Main monitor, set as mirror for unknown displays";
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
      configType = "lua";
      settings = {
        monitor =
          cfg.monitors
          ++ [
            {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = 1;
              mirror = cfg.mainMonitor;
            }
          ];
      };
    };

    stylix.icons = {
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
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };
    home =
      lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
      {
        persistence."/persist".directories = [
          ".local/state/wireplumber"
        ];
      };
  };
}
