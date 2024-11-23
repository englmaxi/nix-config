{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence."/persist/${config.home.homeDirectory}" = let
    fromHome = path:
      with lib.strings;
        removePrefix
        (concatStrings [config.home.homeDirectory "/"])
        path;
  in {
    directories = lib.flatten [
      (map fromHome [
        config.xdg.userDirs.pictures
        config.xdg.userDirs.documents
      ])
      "git"
    ];
    allowOther = true;
  };
}
