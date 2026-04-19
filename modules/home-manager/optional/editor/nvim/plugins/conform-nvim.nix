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
      key = "<leader>f";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end
      '';
      options.desc = "[F]ormat buffer";
    }
  ];
}
