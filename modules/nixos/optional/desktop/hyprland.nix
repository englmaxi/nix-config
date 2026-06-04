{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.inputs.hyprland.hyprland;
      portalPackage = pkgs.inputs.hyprland.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };
  };

  xdg.portal = {
    enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    udev.extraRules = ''      # allow executing light without sudo
           ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';

    greetd = let
      cmd = "uwsm start hyprland.desktop";
    in {
      enable = true;
      settings = {
        default_session.command = "${lib.getExe pkgs.tuigreet} --cmd '${cmd}'";
        default_session.user = "greeter";
      };
    };
  };

  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    home = "/var/lib/greeter";
    createHome = true;
  };

  users.groups.greeter = {};

  environment =
    {
      systemPackages = with pkgs; [
        pamixer
        networkmanagerapplet
        brightnessctl
        tuigreet
      ];
      etc."tuigreet/config.toml".text = ''
        [display]
        show_time = true

        [secret]
        mode = "characters"
        characters = "*"

        [remember]
        username = true
        session = false
        user_session = false

        [[outputs]]
        connector = "DP-2"
        primary = true

        [[outputs]]
        connector = "HDMI-A-3"
        enabled = false
      '';
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.environment)
    {
      persistence."/persist".directories = ["/var/cache/tuigreet"];
    };
}
