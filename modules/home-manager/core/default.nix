{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./git.nix
    ./nh.nix
    ./ssh.nix
    ./user-dirs.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    btop
    fd
    tree
    fzf
    ripgrep
    neofetch
    ncdu
    p7zip
    zip
    unzip
    unrar
    usbutils
    killall
    screen
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues outputs.overlays;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
