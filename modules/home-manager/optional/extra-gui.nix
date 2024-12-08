{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity
    calibre
    gimp
    veracrypt
    vlc
    zoom-us
  ];
}
