{
  config,
  pkgs,
  ...
}: let
  userName = "engl";
in {
  home-manager.users.${userName} = import (../../../../home + "/${userName}/${config.networking.hostName}.nix");

  sops.secrets = {
    "hashed_passwords/${userName}".neededForUsers = true;
    "user_age_keys/${userName}_${config.networking.hostName}" = {
      owner = config.users.users.${userName}.name;
      inherit (config.users.users.${userName}) group;
      path = "/home/${userName}/.config/sops/age/keys.txt";
    };
  };

  users = {
    mutableUsers = false;

    users.${userName} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      home = "/home/${userName}";
      hashedPasswordFile = config.sops.secrets."hashed_passwords/${userName}".path;
      shell = pkgs.zsh;
      packages = [pkgs.home-manager];
    };
  };
}
