{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = let
    spicePkgs = pkgs.inputs.spicetify-nix;
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      powerBar
      keyboardShortcut
    ];
  };

  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}".directories = [
          ".config/spotify"
        ];
      };
    };
}
