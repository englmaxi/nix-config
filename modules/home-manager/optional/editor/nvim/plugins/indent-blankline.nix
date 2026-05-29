{...}: {
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "┃";
        smart_indent_cap = true;
      };
      scope = {
        char = "┃";
        highlight = "Keyword";
        enabled = true;
        show_start = false;
        show_end = false;
        exclude.language = ["nix"];
      };
    };
  };
}
