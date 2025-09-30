{pkgs, ...}: {
  imports = [
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
      ;
  };

  services = {
    clipse.enable = true;
    clipse.imageDisplay.type = "kitty";
    dunst.enable = true;
    hyprpolkitagent.enable = true;
    blueman-applet.enable = true;
    udiskie.enable = true;
  };
}
