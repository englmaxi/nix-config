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
        userName = inputs.secrets.work.config.git.userName;
        email = inputs.secrets.work.config.git.email;
        signingKey = "id_rsa";
      };
      ssh = {
        hostMatchBlocks = false;
        git = [
          {
            host = "gitlab.com";
            sshTunnel = "altssh";
          }
          {
            host = inputs.secrets.config.git.work.instance;
          }
          {
            host = "github.com";
            key = "id_ed25519_sk_rk";
            sshTunnel = "ssh";
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
