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
        music = "${hd}/music";
        videos = "${hd}/videos";
        extraConfig = {
          XDG_PUBLICSHARE_DIR = "/var/empty";
          XDG_TEMPLATES_DIR = "/var/empty";
        };
      };
  };
}
