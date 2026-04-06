{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  options.modules.home-manager.optional.sops = {
    secretsFile = lib.mkOption {
      type = lib.types.str;
      default = "secrets.yaml";
      description = "Path (relative to inputs.secrets) to the sops secrets file.";
    };

    sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["id_lori"];
      description = "List of SSH key names to generate via sops.";
    };
  };

  config = let
    cfg = config.modules.home-manager.optional.sops;
  in {
    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

      defaultSopsFile = "${toString inputs.secrets}/${cfg.secretsFile}";

      secrets = lib.listToAttrs (map (key: {
          name = "ssh_keys/${key}";
          value = {
            path = "${config.home.homeDirectory}/.ssh/${key}";
          };
        })
        cfg.sshKeys);
    };

    # home.activation.generatePublicKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #   for key in ${lib.concatStringsSep " " cfg.sshKeys}; do
    #     privKeyPath="${config.home.homeDirectory}/.ssh/$key"
    #     pubKeyPath="$privKeyPath.pub"
    #
    #     if [ -f "$privKeyPath" ] && [ ! -f "$pubKeyPath" ]; then
    #       run sh -c "${pkgs.openssh}/bin/ssh-keygen -y -f '$privKeyPath' > '$pubKeyPath'"
    #       run chmod 644 "$pubKeyPath"
    #     fi
    #   done
    # '';

    home.packages = [
      pkgs.age
      pkgs.ssh-to-age
      pkgs.sops
    ];
  };
}
