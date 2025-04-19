{
  config,
  lib,
  ...
}: {
  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}" = {
          directories = [
            {
              directory = ".local/share/containers";
              method = "symlink";
            }
          ];
          allowOther = true;
        };
      };
    };
}
