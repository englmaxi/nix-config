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
          (function()
            local cwd = vim.fn.getcwd()
            local display_cwd = vim.fn.fnamemodify(cwd, ":~")
            local stats = ""

            vim.system({
              "${lib.getExe pkgs.eza}",
              "--code",
              cwd,
            }, { text = true }, function(result)
              vim.schedule(function()
                if result.code == 0 then
                  stats = result.stdout
                else
                  stats = ""
                end

                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.bo[buf].filetype == "ministarter" then
                    require("mini.starter").refresh(buf)
                  end
                end
              end)
            end)

            return function()
              return table.concat({
                display_cwd,
                "",
                stats,
              }, "\n")
            end
          end)()
        '';
      };
    };
  };
}
