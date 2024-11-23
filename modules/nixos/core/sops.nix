{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${builtins.toString inputs.secrets}/secrets.yaml";

    age = {
      sshKeyPaths = [
        "${
          lib.optionalString (lib.hasAttr "persistence" config.environment) "/persist"
        }/etc/ssh/ssh_host_ed25519_key"
      ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  environment.defaultPackages = with pkgs; [
    age
    sops
    ssh-to-age
  ];
}
