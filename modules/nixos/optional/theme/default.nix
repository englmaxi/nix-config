{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = import ../../../shared/stylix.nix {inherit pkgs;} // {
    enable = true;
    image = ./wallpaper.png;
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };
}
