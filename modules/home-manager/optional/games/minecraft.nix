{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = with pkgs; [
        prismlauncher
      ];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}" = {
          directories = [
            ".local/share/PrismLauncher"
          ];
        };
      };
    };
}
