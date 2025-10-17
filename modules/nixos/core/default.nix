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

  environment.systemPackages = [
    pkgs.wget
    pkgs.vim
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;

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
