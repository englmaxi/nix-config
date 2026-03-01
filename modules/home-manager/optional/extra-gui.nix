{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      android-tools
      audacity
      # calibre
      chromium
      gimp
      scrcpy
      veracrypt
      vlc
      zoom-us
      ;
  };
}
