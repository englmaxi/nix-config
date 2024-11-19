{
  config,
  lib,
  ...
}: {
  options.modules.nixos.core.locales = with lib; {
    zone = mkOption {
      type = types.str;
      default = "Europe/Vienna";
    };

    language = mkOption {
      type = types.str;
      default = "en_US.utf8";
    };

    keyMap = mkOption {
      type = types.str;
      default = "us";
    };
  };

  config = let
    cfg = config.modules.nixos.core.locales;
  in {
    time.timeZone = cfg.zone;
    i18n.defaultLocale = cfg.language;
    console.keyMap = cfg.keyMap;
    services.xserver.xkb.layout = cfg.keyMap;
  };
}
