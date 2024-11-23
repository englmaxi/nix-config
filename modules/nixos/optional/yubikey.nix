{pkgs, ...}: {
  services.pcscd.enable = true;
  services.udev.packages = [pkgs.yubikey-personalization];

  environment.systemPackages = with pkgs; [
    yubioath-flutter
    yubikey-manager
  ];
}
