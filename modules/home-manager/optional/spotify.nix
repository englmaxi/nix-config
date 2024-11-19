{
  inputs,
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
      shuffle
      skipOrPlayLikedSongs
      powerBar
      keyboardShortcut
    ];
  };
}
