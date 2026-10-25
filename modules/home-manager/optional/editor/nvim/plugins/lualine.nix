_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = ""; #"";
          right = ""; #"";
        };
      };
      sections = {
        lualine_a = [
          "mode"
        ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            path = 1;
            symbols = {
              modified = " ";
              readonly = " ";
              unnamed = "󱁐 ";
              new = " ";
            };
          }
        ];
        lualine_x = [
          {
            __unkeyed-1 = "lsp_status";
            ignore_lsp = ["typos_lsp"];
          }
          {
            __unkeyed-1 = "filetype";
            icon_only = true;
            padding = {
              left = 1;
              right = 0;
            };
          }
          "fileformat"
          "encoding"
        ];
        lualine_y = [
          "filesize"
          {
            __unkeyed-1 = "progress";
            separator = "";
          }
        ];
        lualine_z = [
          "location"
        ];
      };
    };
  };
}
