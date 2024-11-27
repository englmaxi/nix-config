{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = [pkgs.megasync];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}" = {
          directories = [
            ".local/share/data/Mega Limited/MEGAsync"
            "mega"
          ];
        };
      };
    };
}
