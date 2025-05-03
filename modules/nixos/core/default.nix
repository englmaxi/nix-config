{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./locales.nix
    ./logind.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
      };
    };
    printing.enable = true;
    udisks2.enable = true;
  };
}
