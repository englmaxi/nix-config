{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./locales.nix
    ./nix.nix
    ./services/openssh.nix
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
}
