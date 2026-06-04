{
  config,
  lib,
  ...
}: {
  programs.calibre = {
    enable = true;
  };
  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          ".config/calibre"
        ];
      };
    };
}
