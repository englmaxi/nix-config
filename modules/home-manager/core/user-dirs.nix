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
      }
      // ifEnable cfg.shortNames {
        desktop = "${hd}/desktop";
        download = "${hd}/dl";
        documents = "${hd}/docs";
        pictures = "${hd}/pics";
        extraConfig = {
          XDG_MUSIC_DIR = "/var/empty";
          XDG_VIDEOS_DIR = "/var/empty";
          XDG_PUBLICSHARE_DIR = "/var/empty";
          XDG_TEMPLATES_DIR = "/var/empty";
        };
      };
  };
}
