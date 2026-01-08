{
  config,
  lib,
  ...
}: {
  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          {
            directory = ".local/share/containers";
          }
        ];
      };
    };
}
