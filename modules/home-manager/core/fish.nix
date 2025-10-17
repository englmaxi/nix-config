{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins =
        map
        (name: {
          inherit name;
          src = pkgs.fishPlugins."${name}".src;
        })
        [
          "autopair"
          "done"
          "exercism-cli-fish-wrapper"
          "fish-bd"
          "fish-you-should-use"
          "fzf-fish"
          #   "grc"
          "plugin-sudope"
        ];
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings.add_newline = true;
    };

    carapace.enable = true;
    carapace.enableFishIntegration = true;
  };
}
