{inputs, ...}: {
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services.xremap.config.modmap = [
    {
      name = "Global";
      remap = {"CapsLock" = "Esc";};
    }
  ];
}
