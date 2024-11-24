{pkgs,...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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
