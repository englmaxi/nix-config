{...}: {
  services.logind.settings.Login = {
    HandlePowerKey = "poweroff";
    HanldePowerKeyLongPress = "reboot";

    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };
}
