{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      android-tools
      audacity
      calibre
      gimp
      scrcpy
      veracrypt
      vlc
      zoom-us
      ;
  };
}
