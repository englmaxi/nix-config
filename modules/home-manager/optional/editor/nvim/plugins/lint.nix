{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      linters = {
        cppcheck = {
          args = let
            misraRules = "${inputs.misra-rules}/misra_c_2012__headlines_for_cppcheck\\ -\\ AMD1+AMD2.txt";
            misraAddon = pkgs.writeText "misra.json" (builtins.toJSON {
              script = "misra.py";
              args = [
                "--rule-texts=${misraRules}"
              ];
            });
            suppressionList = pkgs.writeText "cppcheck-suppression-list" ''
              misra-c2012-2.4  # we do not care for not used tag declarations
              misra-c2012-2.5  # we do not care for not used macro declarations
              misra-c2012-8.7  # checking external linkage can not be done without a database
              misra-c2012-17.3 # implicit declarations are better handled by clangd
              misra-c2012-19.2 # unions are a very useful tool in embedded C
              misra-c2012-21.6 # do not warn about the Standard Library input/output functions
              misra-config     # misra config warnings
              unknownMacro     # handled by clangd
            '';
          in [
            "--enable=warning,style,performance,portability"
            "--inline-suppr"
            "--quiet"
            "--template={file}:{line}:{column}: [{id}] {severity}: {message}"
            "--addon=${misraAddon}"
            "--suppressions-list=${suppressionList}"
          ];
        };
      };
      lintersByFt = {
        c = [
          "cppcheck"
        ];
      };
    };
    extraConfigLua = ''
      local cppcheck_cache = vim.fn.stdpath("cache") .. "/cppcheck"
      vim.fn.mkdir(cppcheck_cache, "p")

      table.insert(
        require("lint").linters.cppcheck.args,
        "--cppcheck-build-dir=" .. cppcheck_cache
      )
    '';
    extraPackages = [
      pkgs.cppcheck
      pkgs.python3
    ];
  };
}
