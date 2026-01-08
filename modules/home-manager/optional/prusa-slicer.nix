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
      persistence."/persist" = {
        directories = [
          ".local/share/prusa-slicer"
          ".config/PrusaSlicer"
        ];
      };
    };
}
