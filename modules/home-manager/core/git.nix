{
  config,
  lib,
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
      };
    };
  };
}
