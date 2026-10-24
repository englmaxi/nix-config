_: {
  programs.nixvim = {
    extraConfigLuaPost = ''
      local highlights = {
        -- Comments
        ["@comment"] = { italic = true },

        -- Keywords
        ["@keyword"] = { italic = true },
        ["@keyword.conditional"] = { italic = true },
        ["@keyword.repeat"] = { italic = true },
        ["@keyword.return"] = { italic = true },
        ["@keyword.exception"] = { italic = true },

        -- Types
        ["@type.definition"] = { bold = true },
        ["@type.qualifier"] = { italic = true },

        -- Parameters
        ["@variable.parameter"] = { italic = true },

        -- Built-in values
        ["@variable.builtin"] = { italic = true },
        ["@constant.builtin"] = { italic = true },

        -- Strings and documentation
        ["@string.documentation"] = { italic = true },

        -- Markdown
        ["@markup.italic"] = { italic = true },
        ["@markup.strong"] = { bold = true },
        ["@markup.strikethrough"] = { strikethrough = true },
        ["@markup.underline"] = { underline = true },
        ["@markup.heading"] = { bold = true },
      }

      for group, style in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", style, {
          update = true,
        }))
      end
    '';
  };
}
