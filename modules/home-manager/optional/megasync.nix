{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = [pkgs.megasync pkgs.megacmd];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          ".local/share/data/Mega Limited/MEGAsync"
          "mega"
        ];
      };
    };

  systemd.user = {
    startServices = true;
    services.megasync = {
      Unit.Description = "Open MEGASync in the background at boot";
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStart = "${pkgs.megasync}/bin/megasync";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
