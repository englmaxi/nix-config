{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      blink-cmp = {
        enable = true;

        settings = {
          keymap.preset = "super-tab";
          completion = {
            list.selection.auto_insert = false;
            ghost_text.enabled = true;
            documentation.auto_show = true;
          };
          snippets.preset = "luasnip";
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "git"
              "dictionary"
              "thesaurus"
            ];
            providers = {
              thesaurus = {
                name = "blink-cmp-words";
                module = "blink-cmp-words.thesaurus";
                opts = {
                  score_offset = -5;
                  definition_pointers = ["!" "&" "^"];
                  similarity_pointers = ["&" "^"];
                  similarity_depth = 2;
                  max_items = 5;
                };
              };
              dictionary = {
                name = "blink-cmp-words";
                module = "blink-cmp-words.dictionary";
                opts = {
                  dictionary_search_threshold = 3;
                  score_offset = -10;
                  definition_pointers = ["!" "&" "^"];
                  max_items = 5;
                };
              };
              git = {
                name = "git";
                module = "blink-cmp-git";
              };
            };
          };
        };
      };
      blink-cmp-words.enable = true;
      blink-cmp-git.enable = true;
      luasnip.enable = true;
      friendly-snippets.enable = true;
    };
    # extraConfigLua = ''
    #   local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
    #
    #   vim.api.nvim_set_hl(0, "BlinkCmpGhostText", {
    #     fg = comment.fg,
    #     italic = true,
    #   })
    # '';
  };
  home.packages = [pkgs.wordnet];
}
