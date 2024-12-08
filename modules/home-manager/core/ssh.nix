{
  config,
  lib,
  ...
}: let
  hosts = builtins.attrNames (builtins.readDir ../../../hosts);

  hostsMatchBlocks = lib.attrsets.mergeAttrsList (
    lib.lists.map (host: {
      "${host}.local" = {
        hostname = host;
        identityFile = [
          "${config.home.homeDirectory}/.ssh/id_lori"
        ];
      };
    })
    hosts
  );
in {
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "${
      lib.optionalString (lib.hasAttr "persistence" config.home) "/persist"
    }/home/${config.home.username}/.ssh/known_hosts";

    matchBlocks =
      {
        "git" = {
          host = "gitlab.com github.com";
          user = "git";
          forwardAgent = true;
          identitiesOnly = true;
          identityFile = [
            "${config.home.homeDirectory}/.ssh/id_lori"
          ];
        };
      }
      // hostsMatchBlocks;
  };
}
