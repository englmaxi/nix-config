{...}: {
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;

      settings = {
        keymap.preset = "super-tab";
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "dictionary"
            "spell"
          ];
          providers = {
            dictionary = {
              module = "blink-cmp-dictionary";
              name = "Dict";
              score_offset = 100;
              min_keyword_length = 3;
              opts = {};
            };
            spell = {
              module = "blink-cmp-spell";
              name = "Spell";
              score_offset = 100;
              opts = {};
            };
          };
        };
      };
    };
    blink-cmp-dictionary.enable = true;
    blink-cmp-spell.enable = true;
  };
}
