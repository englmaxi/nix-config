{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    udev.packages = with pkgs; [
      gnome-settings-daemon
    ];
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "blackbox";
  };

  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
    ];
    gnome.excludePackages = with pkgs; [
      gnome-console
    ];
  };
}
