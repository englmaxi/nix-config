{inputs, ...}: {
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services.xremap = {
    enable = true;
    config.modmap = [
      {
        name = "Global";
        remap = {"CapsLock" = "Esc";};
      }
    ];
  };
}
