{outputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues outputs.overlays;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    gc = {
      automatic = false;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  system = {
    stateVersion = "24.05";
  };
}
