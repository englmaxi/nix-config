{pkgs, ...}: {
  imports = [
    ./dunst.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./rofi.nix
    ./waybar.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      hyprshot
      nautilus
      qimgv
      evince
      playerctl
      ;
  };

  services = {
    clipse.enable = true;
    clipse.imageDisplay.type = "kitty";
    hyprpolkitagent.enable = true;
    blueman-applet.enable = true;
    udiskie.enable = true;
  };
}
