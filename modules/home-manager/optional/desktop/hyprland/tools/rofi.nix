{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    cycle = true;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      window = {
        border-radius = mkLiteral "14px";
        border = mkLiteral "3px";
        border-color = mkLiteral "@selected-normal-background";
        padding = mkLiteral "10px";
        width = mkLiteral "800px";
      };
      mainbox.spacing = mkLiteral "10px";
      inputbar = {
        padding = mkLiteral "0px 0px 5px";
        border = mkLiteral "0px 0px 2px";
        border-color = mkLiteral "@selected-normal-background";
      };
      entry = {
        font = let inherit (config.stylix) fonts; in "${fonts.monospace.name} Bold ${toString (fonts.sizes.popups + 1)}";
      };
      prompt = {
        margin = mkLiteral "0em 0.3em 0em 0em";
        vertical-align = 1;
      };
      element = {
        border-radius = mkLiteral "4px";
        padding = mkLiteral "4px";
      };
    };
  };
}
