{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        yzhang.markdown-all-in-one
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        arrterian.nix-env-selector
        ms-vscode-remote.remote-containers
      ];
      userSettings = {
        "editor.fontLigatures" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [
                "alejandra"
              ];
            };
          };
        };
        "vim.useSystemClipboard" = true;
      };
    };
  };

  home =
    {
      packages = with pkgs; [
        alejandra
        nixd
      ];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
      persistence = {
        "/persist/${config.home.homeDirectory}".directories = [".config/Code/User"];
      };
    };
}
