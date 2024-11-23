{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
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
