{pkgs, ...}: {
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
            "thesaurus"
          ];
          providers = {
            thesaurus = {
              name = "blink-cmp-words";
              module = "blink-cmp-words.thesaurus";
              opts = {
                score_offset = 0;
                definition_pointers = ["!" "&" "^"];
                similarity_pointers = ["&" "^"];
                similarity_depth = 2;
              };
            };
            dictionary = {
              name = "blink-cmp-words";
              module = "blink-cmp-words.dictionary";
              opts = {
                dictionary_search_threshold = 3;
                score_offset = 0;
                definition_pointers = ["!" "&" "^"];
              };
            };
          };
        };
      };
    };
    blink-cmp-words.enable = true;
  };
  home.packages = [pkgs.wordnet];
}
