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
    enableDefaultConfig = false;
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
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "${
            lib.optionalString (lib.hasAttr "persistence" config.home) "/persist"
          }/home/${config.home.username}/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };
      }
      // hostsMatchBlocks;
  };
}
