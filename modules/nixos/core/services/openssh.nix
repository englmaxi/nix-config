{
  config,
  lib,
  ...
}: {
  options.modules.nixos.optional.services.openssh = with lib; {
    port = mkOption {
      type = types.number;
      default = 22;
    };
  };

  config = let
    cfg = config.modules.nixos.optional.services.openssh;
  in {
    services.openssh = {
      enable = true;
      ports = [cfg.port];

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };

      hostKeys = [
        {
          path = "${
            lib.optionalString (lib.hasAttr "persistence" config.environment) "/persist"
          }/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    services.fail2ban.enable = true;

    networking.firewall.allowedTCPPorts = [cfg.port];
  };
}
