{...}: {
  programs = {
    zsh = {
      enable = true;

      # zprof.enable = true;

      # prezto = {
      #   enable = true;
      #   caseSensitive = false;
      #   tmux = {
      #     autoStartRemote = true;
      #   };
      #   pmodules = [
      #     "environment"
      #     "terminal"
      #     "editor"
      #     "autosuggestions"
      #     "history"
      #     "directory"
      #     "spectrum"
      #     "utility"
      #     "tmux"
      #     "completion"
      #     "prompt"
      #   ];
      # };

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
      settings = {
        add_newline = true;
      };
    };

    carapace = {
      enable = true;
      enableZshIntegration = true;
    };

    # direnv = {
    #   enable = false;
    #   nix-direnv.enable = true;
    #   enableZshIntegration = true;
    # };
  };
}
