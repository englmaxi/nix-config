{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      age
      bitwarden-cli
      git
      home-manager
      nix
      sops
      ssh-to-age
      vim
    ];
  };
}
