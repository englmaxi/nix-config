{...}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>sh" = {
        action = "help_tags";
        options.desc = "[S]earch [H]elp";
      };
      "<leader>sk" = {
        action = "keymaps";
        options.desc = "[S]earch [K]eymaps";
      };
      "<leader>sf" = {
        action = "find_files";
        options.desc = "[S]earch [F]iles";
      };
      "<leader>sd" = {
        action = "diagnostics";
        options.desc = "[S]earch [D]iagnostics";
      };
      "<leader>sw" = {
        action = "grep_string";
        options.desc = "[S]earch current [W]ord";
      };
      "<leader>sg" = {
        action = "live_grep";
        options.desc = "[S]earch by [G]rep";
      };
      "<leader><leader>" = {
        action = "buffers";
        options.desc = "[ ] Find buffers";
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = ''
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        		winblend = 10,
        		previewer = false,
        	}))
        end
      '';
      options.desc = "Fuzzily search in current buffer";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = ''
        function()
          require('telescope.builtin').live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files"
          })
        end
      '';
      options.desc = "Fuzzily [S]earch in [/] open files";
    }
  ];
}
