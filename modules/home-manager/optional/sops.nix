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

    defaultSopsFile = ../../../secrets.yaml;

    secrets = {
      "ssh_keys/lori" = {
        path = "${config.home.homeDirectory}/.ssh/id_lori";
      };
    };
  };

  home.packages = with pkgs; [
    age
    ssh-to-age
    sops
  ];
}
