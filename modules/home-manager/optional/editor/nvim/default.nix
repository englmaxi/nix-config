{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymap.nix
    ./options.nix
    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
