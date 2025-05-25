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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rebecca.yaml";
    override.base01 = "393b60";
    polarity = "dark";
    image = ./wallpaper.png;
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
