{
  config,
  pkgs,
  ...
}: let
  userName = "engl";
in {
  home-manager.users.${userName} = import (../../../../home + "/${userName}/${config.networking.hostName}.nix");

  users = {
    mutableUsers = false;

    sops.secrets.hashedPassword.engl.neededForUsers = true;

    users.engl = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      home = "/home/${userName}";
      hashedPasswordFile = config.sops.secrets.hashedPassword.engl.path;
      shell = pkgs.zsh;
      packages = [pkgs.home-manager];
    };
  };
}
