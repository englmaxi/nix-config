{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      ai.nlines.n_lines = 500;
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
      move = {};
      align = {};
      starter = {
        evaluate_single = true;
        header = lib.generators.mkLuaInline ''
          function()
            local version = vim.version()

            return [=[
                                                      __                
                         ___      __    ___   __  __ /\_\    ___ ___    
                       /' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  
                       /\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ 
                       \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
                        \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
            ]=] .. string.format(
              "\n                                 v%d.%d.%d",
              version.major,
              version.minor,
              version.patch
            )
          end
        '';
        items = [
          {
            name = "Search files";
            action = "Telescope find_files";
            section = "Files";
          }
          {
            name = "Browse files";
            action = "Oil";
            section = "Files";
          }
          {
            name = "New file";
            action = "ene | startinsert";
            section = "Files";
          }
          {
            name = "Quit";
            action = "qa";
            section = "Session";
          }
        ];
        content_hooks = {
          "__unkeyed.adding_bullet".__raw = "require('mini.starter').gen_hook.adding_bullet(' ')";
          "__unkeyed.aligning".__raw = "require('mini.starter').gen_hook.aligning('center', 'center')";
          "__unkeyed.padding".__raw = "require('mini.starter').gen_hook.padding(3, 2)";
        };

        footer = lib.generators.mkLuaInline ''
          function()
            local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")

            local stats = vim.fn.system({
              "${lib.getExe pkgs.eza}",
              "--code",
              vim.fn.getcwd(),
            })

            local result = {
              cwd,
              "",
            }

            if vim.v.shell_error == 0 then
              table.insert(result, stats)
            end

            return table.concat(result, "\n")
          end
        '';
      };
    };
  };
}
