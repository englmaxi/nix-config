{
  config,
  lib,
  ...
}: {
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
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "SSH key name in ~/.ssh/";
          };
          sshTunnel = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Tunnel ssh over HTTPS (<value>.hostname)";
          };
        };
      });
      default = [
        {
          host = "github.com";
        }
        {
          host = "gitlab.com";
        }
      ];
      description = "Git SSH host/key mappings.";
    };

    defaultKey = lib.mkOption {
      type = lib.types.str;
      default = "id_lori";
      description = "Default SSH key";
    };
  };

  config = let
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
        "git-${entry.host}" =
          {
            host = entry.host;
            user = "git";
            forwardAgent = true;
            identitiesOnly = true;
            identityFile = [
              "${config.home.homeDirectory}/.ssh/${
                if entry.key != null
                then entry.key
                else cfg.defaultKey
              }"
            ];
          }
          // lib.optionalAttrs (entry.sshTunnel != null) {
            hostname = "${entry.sshTunnel}.${entry.host}";
            port = 443;
          };
      })
      cfg.git
    );
  in {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks =
        {
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "no";
            compression = false;
            serverAliveInterval = 60;
            serverAliveCountMax = 3;
            hashKnownHosts = true;
            userKnownHostsFile = "${lib.optionalString (lib.hasAttr "persistence" config.home) "/persist"}/home/${config.home.username}/.ssh/known_hosts";
            controlMaster = "auto";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "5m";
          };
        }
        // gitMatchBlocks
        // hostsMatchBlocks;
    };
  };
}
