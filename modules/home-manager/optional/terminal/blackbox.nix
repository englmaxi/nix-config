{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.blackbox-terminal];

  dconf.settings = {
    "com/raggesilver/BlackBox" = {
      terminal-bell = false;
      theme-dark = "stylix-base16";
      pretty = false;
      terminal-padding = with lib.hm.gvariant; let
        p = mkUint32 18;
      in
        mkTuple [p p p p];
      font = let
        inherit (config.stylix.fonts) monospace sizes
          ;
      in
        lib.strings.concatStringsSep " " [
          monospace.name
          (
            builtins.toString
            sizes.terminal
          )
        ];
    };
  };

  home = {
    sessionVariables.TERMINAL = "blackbox";
    file = {
      ".local/share/blackbox/schemes/stylix-base16.json" = {
        text = with config.lib.stylix.colors.withHashtag;
          builtins.toJSON {
            name = "stylix-base16";
            foreground-color = base05;
            background-color = base00;
            use-theme-colors = false;
            palette = [
              base00
              base08
              base0B
              base0A
              base0D
              base0E
              base0C
              base05
              base03
              base09
              base01
              base02
              base04
              base06
              base0F
              base07
            ];
          };
      };
    };
  };
}
