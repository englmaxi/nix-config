{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs.nerd-fonts)
      fira-code
      symbols-only
      ;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font"];
      sansSerif = ["Fira Sans"];
      serif = ["Fira Sans"];
    };
  };
}
