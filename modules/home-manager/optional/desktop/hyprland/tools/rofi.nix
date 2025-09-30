{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji-wayland
    ];
  };
}
