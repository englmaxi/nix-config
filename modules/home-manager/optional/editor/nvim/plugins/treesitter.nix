{pkgs,...}: {
  programs.nixvim.plugins.treesitter = {
    enable = true;

    nixvimInjections = true;

    settings = {
      highlight.enable = true;
      indent.enable = true;
      autotag.enable = true;
      folding.enable = true;
      autoinstall = true;
      nixvimInjections = true;
    };
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      clang
      zig
      ;
  };
}
