{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza --group-directories-first";
        ll = "eza -l --group-directories-first";
        la = "eza -a --group-directories-first";
        lla = "eza -la --group-directories-first";
        cat = "bat";
      };
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

    bat.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    };
  };
  home.packages = [pkgs.grc pkgs.eza]; # dependencies
}
