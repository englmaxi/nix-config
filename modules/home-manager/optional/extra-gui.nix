{pkgs, ...}: {
  home.packages = with pkgs; [
    android-tools
    audacity
    chromium
    gimp
    kicad
    scrcpy
    veracrypt
    vlc
    zmk-studio
    zoom-us
  ];
}
