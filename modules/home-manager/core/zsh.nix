{...}: {
  programs = {
    zsh = {
      enable = true;

      prezto = {
        enable = true;
        caseSensitive = false;
        tmux = {
          autoStartRemote = true;
        };
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "autosuggestions"
          "history"
          "directory"
          "spectrum"
          "utility"
          "tmux"
          "completion"
          "prompt"
        ];
      };

      initExtra = ''
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_IGNORE_DUPS
        setopt HIST_IGNORE_SPACE
        setopt HIST_SAVE_NO_DUPS
        setopt INC_APPEND_HISTORY
      '';

      # oh-my-zsh = {
      #   enable = true;
      #   plugins = [
      #     "sudo"
      #     "git"
      #     "colored-man-pages"
      #   ];
      # };
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

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
