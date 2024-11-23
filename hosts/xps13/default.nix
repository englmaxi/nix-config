{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # modules
    inputs.nixos-hardware.nixosModules.dell-xps-13-9360
    inputs.disko.nixosModules.disko

    # hardware
    ./disks.nix
    ./hardware-configuration.nix

    #core
    ../../modules/nixos/core

    # optional
    ../../modules/nixos/optional/desktop/gnome.nix
    ../../modules/nixos/optional/impermanence.nix
    ../../modules/nixos/optional/theme/catppuccin-mocha
    ../../modules/nixos/optional/yubikey.nix

    # users
    ../../modules/nixos/user/engl
  ];

  modules.nixos = {
    core = {
      locales.keyMap = "de";
    };
  };

  networking = {
    hostName = "xps13";
    networkmanager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
}
