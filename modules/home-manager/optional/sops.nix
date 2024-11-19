{
  inputs,
  pkgs,
  ...
}: {
  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];
  };

  home.packages = with pkgs; [
    age
    ssh-to-age
    sops
  ];
}
