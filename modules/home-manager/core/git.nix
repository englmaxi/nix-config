{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home-manager.core.git = with lib; {
    userName = mkOption {
      type = types.str;
      default = "";
    };
    email = mkOption {
      type = types.str;
      default = "";
    };
    signingKey = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };

  config = let
    cfg = config.modules.home-manager.core.git;
  in {
    programs = {
      git = {
        enable = true;
        settings = {
          user.name = cfg.userName;
          user.email = cfg.email;
          init.defaultBranch = "main";
          diff.algorithm = "histogram";
          merge.conflictStyle = "zdiff3";
        };
        signing =
          {
            format = "ssh";
          }
          // lib.optionalAttrs (cfg.signingKey != null) {
            key = "${config.home.homeDirectory}/.ssh/${cfg.signingKey}";
            signByDefault = true;
          };
      };
      lazygit.enable = true;
      lazygit.settings = {
        disableStartupPopups = true;
        quitOnTopLevelReturn = true;
        git.overrideGpg = true;
        git.diffRenderers = lib.lists.singleton {
          command = lib.strings.escapeShellArgs [
            "${lib.getExe pkgs.delta}"
            "--paging=never"
            "--line-numbers"
            "--hyperlinks"
            "--hyperlinks-file-link-format=lazygit-edit://{path}:{line}"
          ];
        };
        gui.showRandomTip = false;
        gui.fileTreeSortOrder = "foldersFirst";
        gui.nerdFontsVersion = "3";
      };
    };
  };
}
