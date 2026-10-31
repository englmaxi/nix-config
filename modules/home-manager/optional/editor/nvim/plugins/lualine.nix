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
          left = ""; # "";
          right = ""; # "";
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
          {
            # encoding
            __unkeyed-1.__raw = ''
              function()
                local enc = vim.bo.fileencoding
                if enc ~= "" and enc:lower() ~= "utf-8" then
                  return enc
                end
                return ""
              end
            '';
          }
        ];
        lualine_y = [
          "filesize"
        ];
        lualine_z = [
          {
            __unkeyed-1 = "location";
            separator = "/";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed-1 = "%L";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];
      };
    };
  };
}
