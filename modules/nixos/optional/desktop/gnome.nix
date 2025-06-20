{pkgs, ...}: {
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xserver.enable = true;
    udev.packages = [pkgs.gnome-settings-daemon];
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "blackbox";
  };

  environment = {
    systemPackages = [pkgs.gnome-tweaks];
    gnome.excludePackages = [pkgs.gnome-console];
  };
}
