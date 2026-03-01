{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.obsidian = {
    enable = true;
    vaults.vault.settings.appearance."textFontFamily" = "Atkinson Hyperlegible Next";
  };
  stylix.targets.obsidian = {
    vaultNames = ["vault"];
    fonts.override.sizes.applications = 16;
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
