{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = [pkgs.prismlauncher];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          ".local/share/PrismLauncher"
        ];
      };
    };
}
