{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = [
        # pkgs.megasync
        pkgs.megacmd
      ];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence."/persist" = {
        directories = [
          ".megaCmd"
          # ".local/share/data/Mega Limited/MEGAsync"
          "mega"
        ];
      };
    };

  systemd.user = {
    startServices = true;
    services.mega-cmd-server = {
      Unit = {
        Description = "MEGA CMD Server (user)";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.megacmd}/bin/mega-cmd-server";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
    # services.megasync = {
    #   Unit.Description = "Open MEGASync in the background at boot";
    #   Install.WantedBy = ["default.target"];
    #   Service = {
    #     ExecStart = "${pkgs.megasync}/bin/megasync";
    #     Restart = "on-failure";
    #     RestartSec = "5s";
    #   };
    # };
  };
}
