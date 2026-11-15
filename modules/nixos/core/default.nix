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

  programs.zsh.enable = true;
  programs.fish.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      settings.publish = {
        disable-publishing = false;
        addresses = true;
        domain = true;
        hinfo = true;
      };
    };
    printing.enable = true;
    udisks2.enable = true;
  };
}
