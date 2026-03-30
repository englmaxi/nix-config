{
  config,
  lib,
  ...
}: let
  cfg = config.modules.home-manager.core.ssh;

  hosts =
    if cfg.hostMatchBlocks
    then builtins.attrNames (builtins.readDir ../../../hosts)
    else [];

  hostsMatchBlocks = lib.attrsets.mergeAttrsList (
    map (host: {
      "${host}.local" = {
        hostname = host;
        identityFile = [
          "${config.home.homeDirectory}/.ssh/${cfg.defaultKey}"
        ];
      };
    })
    hosts
  );

  gitMatchBlocks = lib.attrsets.mergeAttrsList (
    map (entry: {
      "git-${entry.host}" = {
        host = entry.host;
        user = "git";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          "${config.home.homeDirectory}/.ssh/${entry.key}"
        ];
      };
    })
    cfg.git
  );
in {
  options.modules.home-manager.core.ssh = {
    hostMatchBlocks = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable automatic match blocks for local hosts.";
    };

    git = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          host = lib.mkOption {
            type = lib.types.str;
            description = "Git host (e.g. github.com)";
          };
          key = lib.mkOption {
            type = lib.types.str;
            description = "SSH key name in ~/.ssh/";
          };
        };
      });
      default = [
        {
          host = "github.com";
          key = "id_lori";
        }
        {
          host = "gitlab.com";
          key = "id_lori";
        }
      ];
      description = "Git SSH host/key mappings.";
    };

    defaultKey = lib.mkOption {
      type = lib.types.str;
      default = "id_lori";
      description = "Default SSH key for non-git hosts.";
    };
  };

  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks =
        {
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "no";
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "${lib.optionalString (lib.hasAttr "persistence" config.home) "/persist"}/home/${config.home.username}/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
          };
        }
        // gitMatchBlocks
        // hostsMatchBlocks;
    };
  };
}
