{
  config,
  pkgs,
  ...
}: let
  userName = "engl";
in {
  home-manager.users.${userName} = import (../../../../home + "/${userName}/${config.networking.hostName}.nix");

  sops.secrets."hashed_passwords/${userName}".neededForUsers = true;

  users = {
    mutableUsers = false;

    users.engl = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      home = "/home/${userName}";
      hashedPasswordFile = config.sops.secrets."hashed_passwords/${userName}".path;
      shell = pkgs.zsh;
      packages = [pkgs.home-manager];
    };
  };
}
