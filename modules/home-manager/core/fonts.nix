{config, pkgs, ...}: let
  inherit (config.stylix) fonts;
in {
  home.packages = [
    fonts.monospace.package
    fonts.sansSerif.package
    fonts.serif.package
    fonts.emoji.package
    pkgs.nerd-fonts.symbols-only
  ];

  fonts.fontconfig.enable = true;
}
