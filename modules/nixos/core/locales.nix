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
      default = "en_US.UTF-8";
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
    i18n.defaultLocale = "de_DE.UTF-8";
    i18n.extraLocaleSettings = {
      LC_MESSAGES = cfg.language;
    };
    i18n.extraLocales = [
      "de_DE.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "it_IT.UTF-8/UTF-8"
    ];
    console.keyMap = cfg.keyMap;
    services.xserver.xkb.layout = cfg.keyMap;
  };
}
