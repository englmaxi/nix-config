{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${builtins.toString inputs.secrets}/secrets.yaml";

    secrets = {
      "ssh_keys/lori" = {
        path = "${config.home.homeDirectory}/.ssh/id_lori";
      };
    };
  };

  home.packages = [
    pkgs.age
    pkgs.ssh-to-age
    pkgs.sops
  ];
}
