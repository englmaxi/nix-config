{inputs, ...}: let
  userName = "engl";
in {
  imports = [
    # core
    ../../modules/home-manager/core

    # optional
    ../../modules/home-manager/optional/browser/firefox.nix
    ../../modules/home-manager/optional/desktop/hyprland
    ../../modules/home-manager/optional/editor/nvim
    ../../modules/home-manager/optional/editor/vscode.nix
    ../../modules/home-manager/optional/extra-gui.nix
    ../../modules/home-manager/optional/impermanence.nix
    ../../modules/home-manager/optional/megasync.nix
    ../../modules/home-manager/optional/sops.nix
    ../../modules/home-manager/optional/spotify.nix
    ../../modules/home-manager/optional/social/discord.nix
    ../../modules/home-manager/optional/terminal/kitty.nix
  ];

  modules.home-manager = {
    core = {
      git = {
        userName = "englmaxi";
        email = inputs.secrets.config.git.email;
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
