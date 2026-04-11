{
  config,
  lib,
  ...
}:
with lib; {
  options.modules.home-manager.core.user-dirs = {
    createDirs = mkOption {
      type = types.bool;
      default = false;
    };
    shortNames = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = let
    cfg = config.modules.home-manager.core.user-dirs;
    hd = config.home.homeDirectory;
  in {
    xdg.userDirs =
      {
        enable = true;
        createDirectories = cfg.createDirs;
        setSessionVariables = true;
      }
      // ifEnable cfg.shortNames {
        desktop = "${hd}/desktop";
        download = "${hd}/dl";
        documents = "${hd}/docs";
        pictures = "${hd}/pics";
        extraConfig = {
          MUSIC = "/var/empty";
          VIDEOS = "/var/empty";
          PUBLICSHARE = "/var/empty";
          TEMPLATES = "/var/empty";
        };
      };
  };
}
