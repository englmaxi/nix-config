{
  config,
  lib,
  ...
}: let
  hosts = builtins.attrNames (builtins.readDir ../../../hosts);

  hostsMatchBlocks = lib.attrsets.mergeAttrsList (
    lib.lists.map (host: {
      "${host}" = {
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

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".ssh/known_hosts"];
    };
  };
}
