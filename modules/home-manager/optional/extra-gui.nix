{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      android-tools
      audacity
      # calibre
      chromium
      gimp
      kicad
      scrcpy
      veracrypt
      vlc
      zmk-studio
      zoom-us
      ;
  };
}
