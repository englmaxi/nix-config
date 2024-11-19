{
  config,
  lib,
  ...
}:
with lib; {
  options.modules.home-manager.core.git = {
    userName = mkOption {
      type = types.str;
      default = "";
    };
    email = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = let
    cfg = config.modules.home-manager.core.git;
  in {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.email;
      extraConfig.init.defaultBranch = "main";
    };
  };
}
