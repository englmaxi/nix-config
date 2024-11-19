{lib, ...}: let
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
      audible-bell = true;
    };
    "org/gnome/shell" = {
      welcome-dialog-last-shown-version = "47.0";
      favorite-apps = [];
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
  };
}
