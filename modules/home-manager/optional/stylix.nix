{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = import ../../shared/stylix.nix {inherit pkgs;} // {
    enable = true;
  };
}
