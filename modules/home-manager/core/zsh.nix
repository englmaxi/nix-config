{...}: {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;

      plugins = [
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "git"
          "colored-man-pages"
        ];
      };

      initExtra = "eval \"\$(direnv hook zsh)\"";
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
