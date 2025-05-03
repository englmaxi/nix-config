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
    light.enable = true;
  };

  security.rtkit.enable = true;
  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    udev.extraRules = '' # allow executing light without sudo
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';

    greetd = let
      cmd = "uwsm start hyprland-uwsm.desktop";
      options = "--time --remember --remember-user-session";
    in {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet ${options} --cmd '${cmd}'";
          user = "greeter";
        };
      };
    };
  };

  environment =
    {
      systemPackages = with pkgs; [
        pamixer
        networkmanagerapplet
      ];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.environment)
    {
      persistence."/persist".directories = ["/var/cache/tuigreet"];
    };
}
