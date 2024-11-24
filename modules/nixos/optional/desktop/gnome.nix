{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "blackbox";
  };

  environment = {
    systemPackages = with pkgs; [
      blackbox-terminal
    ];
    gnome.excludePackages = with pkgs; [
      gnome-console
    ];
  };
}
