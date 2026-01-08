{
  config,
  inputs,
  lib,
  ...
}: {
  home.persistence."/persist" = let
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
  };
}
