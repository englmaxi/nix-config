{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    cycle = true;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];
  };
}
