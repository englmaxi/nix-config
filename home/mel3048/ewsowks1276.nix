{inputs, ...}: let
  userName = baseNameOf (toString ./.);
in {
  imports = [
    # core
    ../../modules/home-manager/core

    # optional
    ../../modules/home-manager/optional/editor/nvim
    ../../modules/home-manager/optional/sops.nix
    ../../modules/home-manager/optional/stylix.nix
  ];

  modules.home-manager = {
    core = {
      git = {
        userName = inputs.secrets.config.git.work.userName;
        email = inputs.secrets.config.git.work.email;
      };
      ssh = {
        hostMatchBlocks = false;
        git = [
          {
            host = "gitlab.com";
            key = "id_rsa";
          }
          {
            host = inputs.secrets.config.git.work.instance;
            key = "id_rsa";
          }
          {
            host = "github.com";
            key = "id_ed25519_sk_rk";
          }
        ];
        defaultKey = "id_rsa";
      };
    };
    optional = {
      sops = {
        secretsFile = "secrets-work.yaml";
        sshKeys = [];
      };
    };
  };

  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
  };
}
