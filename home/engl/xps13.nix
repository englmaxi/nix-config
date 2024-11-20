{...}: let
  userName = "engl";
in {
  imports = [
    # core
    ../../modules/home-manager/core

    # optional
    ../../modules/home-manager/optional/browser/firefox.nix
    ../../modules/home-manager/optional/desktop/gnome.nix
    ../../modules/home-manager/optional/editor/neovim.nix
    ../../modules/home-manager/optional/editor/vscode.nix
    ../../modules/home-manager/optional/impermanence.nix
    ../../modules/home-manager/optional/sops.nix
    ../../modules/home-manager/optional/spotify.nix
    ../../modules/home-manager/optional/terminal/kitty.nix
  ];

  modules.home-manager = {
    core = {
      git = {
        userName = "englmaxi";
        email = "engl@disroot.org"; # TODO: sops
      };
      user-dirs = {
        createDirs = true;
        shortNames = true;
      };
    };
  };

  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
  };
}
