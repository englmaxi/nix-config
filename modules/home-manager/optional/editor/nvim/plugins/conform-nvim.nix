{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters = {
        alejandra = {
          command = lib.getExe pkgs.alejandra;
        };
        squeeze_blanks = {
          command = lib.getExe' pkgs.coreutils "cat";
        };
        shellcheck = {
          command = lib.getExe pkgs.shellcheck;
        };
        shellharden = {
          command = lib.getExe pkgs.shellharden;
        };
        shfmt = {
          command = lib.getExe pkgs.shfmt;
          args = "-i=2";
        };
        ruff = {
          command = lib.getExe pkgs.ruff;
          args = "format";
          stdin = false;
        };
        stylua = {
          command = lib.getExe pkgs.stylua;
        };
        prettierd = {
          command = lib.getExe pkgs.prettierd;
        };
        rustfmt = {
          command = lib.getExe pkgs.rustfmt;
        };
        clang_format = {
          command = lib.getExe' pkgs.clang-tools "clang-format";
        };
        xml-formatter = {
          command = lib.getExe pkgs.xmlformat;
        };
      };
      formatters_by_ft = {
        nix = ["alejandra"];
        bash = ["shellcheck" "shellharden" "shfmt"];
        sh = ["shellcheck" "shellharden" "shfmt"];
        python = ["ruff"];
        c = ["clang_format"];
        cpp = ["clang_format"];
        lua = ["stylua"];
        javascript = ["prettierd"];
        typescript = ["prettierd"];
        html = ["prettierd"];
        rust = ["rustfmt"];
        xml = ["xml-formatter"];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = "";
      key = "<leader>fb";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end
      '';
      options.desc = "[F]ormat [B]uffer";
    }
    {
      mode = "";
      key = "<leader>fc";
      action.__raw = ''
        function()
          local hunks = require("gitsigns").get_hunks()
          local format = require("conform").format
          for i = #hunks, 1, -1 do
            local hunk = hunks[i]
            if hunk ~= nil and hunk.type ~= "delete" then
              local start = hunk.added.start
              local last = start + hunk.added.count
              -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
              local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
              local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
              format({ range = range })
            end
          end
        end
      '';
      options.desc = "[F]ormat [C]hanges";
    }
  ];
}
