{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./comma.nix
    ./fastfetch.nix
    ./fonts.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./user-dirs.nix
    ./yazi.nix
    ./fish.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      btop
      dua
      dust
      fd
      fzf
      glow
      hyperfine
      just
      killall
      ncdu
      nix-output-monitor
      p7zip
      ripgrep
      screen
      tldr
      tree
      unrar
      unzip
      usbutils
      uutils-coreutils-noprefix
      wget
      wl-clipboard
      xsel
      zip
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
