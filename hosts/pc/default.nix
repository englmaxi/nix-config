{
  inputs,
  pkgs,
  ...
}: let
  hostName = "pc";
in {
  imports = [
    # modules
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
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

  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    inherit hostName;
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

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
  };
}
