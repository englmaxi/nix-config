{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rebecca.yaml";
    override.base01 = "323353";
    override.base07 = "A3A3FA";
    override.base09 = "FAC297";
    override.base0A = "EFE4A1";
    override.base0D = "78B2FF";
    polarity = "dark";
  };
}
