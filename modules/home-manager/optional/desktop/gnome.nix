{
  config,
  lib,
  pkgs,
  ...
}: let
  weatherLocation = with lib.gvariant; [
    (mkVariant (mkTuple [
      (mkUint32 2)
      (mkVariant (mkTuple [
        "Vienna"
        "LOWW"
        true
        [(mkTuple [0.83979426423570236 0.2891428852314914])]
        [(mkTuple [0.84124869946126679 0.28565222672750273])]
      ]))
    ]))
  ];
in {
  dconf.settings = {
    # $ dconf-editor
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
    };
    "org/gnome/Console" = {
      audible-bell = false;
    };
    "org/gnome/shell" = {
      welcome-dialog-last-shown-version = "47.0";
      favorite-apps = [];
      disable-user-extensions = false;

      # $ gnome-extensions list
      enabled-extensions = [
        "trayIconsReloaded@selfmade.pl"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "status-icons@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };
    "org/gnome/Weather" = {
      locations = weatherLocation;
    };
    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = weatherLocation;
    };
    "com/raggesilver/BlackBox" = {
      terminal-bell = false;
      theme-dark = "stylix-base16";
      pretty = false;
      terminal-padding = with lib.hm.gvariant; let
        p = mkUint32 18;
      in
        mkTuple [p p p p];
      font = with config.stylix.fonts;
        lib.strings.concatStringsSep " " [
          monospace.name
          (
            builtins.toString
            sizes.terminal
          )
        ];
    };
  };

  #home.packages = with pkgs.gnomeExtensions; [
  #  tray-icons-reloaded
  #  appindicator
  #];

  home = {
    sessionVariables.TERMINAL = "blackbox";
    file = {
      ".local/share/blackbox/schemes/stylix-base16.json" = {
        text = with config.lib.stylix.colors.withHashtag;
          builtins.toJSON {
            name = "stylix-base16";
            foreground-color = base05;
            background-color = base00;
            use-theme-colors = false;
            palette = [
              base00
              base08
              base0B
              base0A
              base0D
              base0E
              base0C
              base05
              base03
              base09
              base01
              base02
              base04
              base06
              base0F
              base07
            ];
          };
      };
    };
  };
}
