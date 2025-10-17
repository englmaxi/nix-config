{...}: {
  programs = {
    zsh = {
      enable = true;

      history = {
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        saveNoDups = true;
        share = true;
        append = true;
      };

      autosuggestion.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "git"
        ];
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings.add_newline = true;
    };

    carapace.enable = true;
    carapace.enableZshIntegration = true;
  };
}
