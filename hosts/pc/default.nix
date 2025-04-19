{
  config,
  inputs,
  pkgs,
  ...
}: let
  hostName = "pc";
in {
  imports = [
    # modules
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-intel-disable
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-sync
    inputs.disko.nixosModules.disko

    # hardware
    ./disks.nix
    ./hardware-configuration.nix

    #core
    ../../modules/nixos/core

    # optional
    ../../modules/nixos/optional/desktop/gnome.nix
    ../../modules/nixos/optional/impermanence.nix
    ../../modules/nixos/optional/podman.nix
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

  boot.supportedFilesystems = ["ntfs"];

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.config.nvidia.acceptLicense = true;

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };

    nvidia = {
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      prime = {
        # lshw -c display
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
