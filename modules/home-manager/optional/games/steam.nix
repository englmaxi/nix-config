{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = builtins.attrValues {
        inherit
          (pkgs)
          steam
          gamescope
          protontricks
          ;
      };
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          ".local/share/Steam"
        ];
      };
    };
}
