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
      };
      formatters_by_ft = {
        nix = ["alejandra"];
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
