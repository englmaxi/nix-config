{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./comma.nix
    ./fonts.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./user-dirs.nix
    ./yazi.nix
    ./zsh.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      btop
      fd
      tree
      fzf
      ripgrep
      fastfetch
      ncdu
      p7zip
      zip
      unzip
      unrar
      usbutils
      killall
      screen
      wget
      xsel
      wl-clipboard
      ;
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues outputs.overlays;
  };

  xdg.mimeApps.enable = true;

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
