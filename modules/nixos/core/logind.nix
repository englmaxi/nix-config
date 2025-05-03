{...}: {
  services.logind = {
    powerKey = "poweroff";
    powerKeyLongPress = "reboot";

    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };
}
