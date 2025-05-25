{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
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
