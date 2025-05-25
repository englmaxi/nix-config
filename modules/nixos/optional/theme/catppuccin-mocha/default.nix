{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    image = ./wallpaper.png;
    opacity.desktop = 0.75;
    fonts = {
      serif.package = pkgs.fira;
      serif.name = "Fira Serif";

      sansSerif.package = pkgs.fira;
      sansSerif.name = "Fira Sans";

      monospace.package = pkgs.nerd-fonts.fira-code;
      monospace.name = "FiraCode Nerd Font Mono";

      emoji.package = pkgs.noto-fonts-emoji;
      emoji.name = "Noto Color Emoji";
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };
}
