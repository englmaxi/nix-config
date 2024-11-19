{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = ["FiraCode"];
    })
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font"];
      sansSerif = ["Fira Sans"];
      serif = ["Fira Sans"];
    };
  };
}
