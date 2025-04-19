{
  config,
  lib,
  pkgs,
  ...
}: let
  userName = "engl";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  home-manager.users.${userName} = import (../../../../home + "/${userName}/${config.networking.hostName}.nix");

  users = {
    mutableUsers = false;

    users.${userName} = {
      isNormalUser = true;
      extraGroups = ifTheyExist [
        "audio"
        "network"
        "video"
        "podman"
        "wheel"
      ];
      home = "/home/${userName}";
      hashedPasswordFile = config.sops.secrets."hashed_passwords/${userName}".path;
      shell = pkgs.zsh;
      packages = [pkgs.home-manager];

      openssh.authorizedKeys.keys =
        lib.lists.forEach
        (lib.filesystem.listFilesRecursive ./keys)
        (key: builtins.readFile key);
    };
  };

  system.activationScripts.sopsSetAgeKeyOwnership = let
    configFolder = "/home/${userName}/.config";
    owner = config.users.users.${userName}.name;
    inherit (config.users.users.${userName}) group;
  in ''
    mkdir -p ${configFolder}/sops/age || true
    chown -R ${owner}:${group} ${configFolder}
  '';

  sops.secrets = {
    "hashed_passwords/${userName}".neededForUsers = true;
    "user_age_keys/${userName}_${config.networking.hostName}" = {
      owner = config.users.users.${userName}.name;
      inherit (config.users.users.${userName}) group;
      path = "/home/${userName}/.config/sops/age/keys.txt";
    };
  };
}
