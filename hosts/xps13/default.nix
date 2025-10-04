{inputs, ...}: let
  hostName = "xps13";
in {
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
    ../../modules/nixos/optional/auto-cpufreq.nix
    ../../modules/nixos/optional/desktop/hyprland.nix
    ../../modules/nixos/optional/impermanence.nix
    ../../modules/nixos/optional/theme/rebecca
    ../../modules/nixos/optional/yubikey.nix
    ../../modules/nixos/optional/xremap.nix

    # users
    ../../modules/nixos/user/engl
  ];

  modules.nixos = {
    core = {
      locales.keyMap = "de";
    };
  };

  networking = {
    inherit hostName;
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [
      "resume_offset=64562432" # "$ btrfs inspect-internal map-swapfile -r /swap/swapfile"
    ];
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16392;
    }
  ];

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  services = {
    upower.enable = true;
  };
}
