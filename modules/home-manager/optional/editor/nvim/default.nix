{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
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
