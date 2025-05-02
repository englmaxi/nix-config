{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji-wayland
    ];
  };
}
