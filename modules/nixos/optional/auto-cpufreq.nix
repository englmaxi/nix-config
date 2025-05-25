{inputs, ...}: {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  services.tlp.enable = false;
  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger.governor = "performance";
      charger.turbo = "auto";
      battery.governor = "powersave";
      battery.turbo = "auto";
    };
  };
}
