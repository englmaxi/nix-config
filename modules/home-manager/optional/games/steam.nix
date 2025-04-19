{
  config,
  lib,
  pkgs,
  ...
}: {  home =
    {
      packages = with pkgs; [
        steam
        gamescope
        protontricks
      ];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}" = {
          directories = [
            ".local/share/Steam"
          ];
        };
      };
    };
}
