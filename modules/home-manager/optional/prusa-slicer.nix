{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = [pkgs.prusa-slicer];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}" = {
          directories = [
            ".local/share/prusa-slicer"
          ];
        };
      };
    };
}
