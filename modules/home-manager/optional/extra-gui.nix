{pkgs, ...}: {
  home.packages = with pkgs; [
    android-tools
    audacity
    calibre
    gimp
    scrcpy
    veracrypt
    vlc
    zoom-us
  ];
}
