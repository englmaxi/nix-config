{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set -g fish_key_bindings fish_vi_key_bindings
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
          "fish-bd"
          "fish-you-should-use"
          "fzf-fish"
          "grc"
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
  home.packages = [pkgs.grc]; # dependency for grc plugin
}
