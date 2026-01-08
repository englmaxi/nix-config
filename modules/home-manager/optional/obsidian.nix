{
  config,
  lib,
  ...
}: {
  programs.obsidian = {
    enable = true;
  };
  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          ".config/obsidian"
          "vault"
        ];
      };
    };
}
