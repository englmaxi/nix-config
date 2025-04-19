{...}: {
  programs = {
    zsh = {
      enable = true;

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
