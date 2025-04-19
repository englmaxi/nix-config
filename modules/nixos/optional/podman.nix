{
  config,
  lib,
  ...
}: let
  dockerIsEnabled = config.virtualisation.docker.enable;
in {
  virtualisation.podman = {
    enable = true;
    dockerCompat = !dockerIsEnabled;
    dockerSocket.enable = !dockerIsEnabled;
  };

  environment =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.environment)
    {
      persistence."/persist".directories = ["/var/lib/containers"];
    };
}
