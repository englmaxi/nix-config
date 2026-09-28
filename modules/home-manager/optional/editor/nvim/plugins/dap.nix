{config, ...}: {
  programs.nixvim = {
    plugins = {
      dap-disasm = {
        enable = true;
        settings = {
          dapview_register = true;
        };
        luaConfig.pre = ''require("dap-view")'';
      };
      dap-view = {
        enable = true;
        settings = {
          virtual_text.enabled = true;
          auto_toggle = true;
          winbar = {
            sections = ["watches" "scopes" "exceptions" "breakpoints" "threads" "repl" "disassembly"];
            controls.enabled = true;
          };
        };
      };
      dap = {
        enable = true;
        adapters = {
          executables.gdb = {
            command = "gdb";
            args = ["--interpreter=dap" "--eval-command" "set print pretty on"];
          };
        };
        configurations = {
          c = [
            {
              name = "Launch";
              type = "gdb";
              request = "launch";
              program.__raw = ''
                function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end
              '';
              cwd = "\${workspaceFolder}";
              stopAtBeginningOfMainSubprogram = true;
            }
            {
              name = "Select and attach to process";
              type = "gdb";
              request = "attach";
              program.__raw = ''
                function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end
              '';
              pid.__raw = ''
                function()
                  local name = vim.fn.input('Executable name (filter): ')
                  return require("dap.utils").pick_process({ filter = name })
                end
              '';
              cwd = "\${workspaceFolder}";
            }
            {
              name = "Attach to gdbserver :1234";
              type = "gdb";
              request = "attach";
              target = "localhost:1234";
              program.__raw = ''
                function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end
              '';
              cwd = "\${workspaceFolder}";
            }
          ];
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<F4>";
        action.__raw = ''
          function() require('dap').terminate() end
        '';
      }
      {
        mode = "n";
        key = "<F5>";
        action.__raw = ''
          function() require('dap').continue() end
        '';
      }
      {
        mode = "n";
        key = "<F6>";
        action.__raw = ''
          function() require('dap').pause() end
        '';
      }
      {
        mode = "n";
        key = "<F10>";
        action.__raw = ''
          function() require('dap').step_over() end
        '';
      }
      {
        mode = "n";
        key = "<F11>";
        action.__raw = ''
          function() require('dap').step_into() end
        '';
      }
      {
        mode = "n";
        key = "<F12>";
        action.__raw = ''
          function() require('dap').step_out() end
        '';
      }
      {
        mode = "n";
        key = "<leader>dh";
        action.__raw = ''
          function() require('dap-view').hover() end
        '';
        options.desc = "[D]ap [H]over";
      }
      {
        mode = "n";
        key = "<leader>tb";
        action.__raw = ''
          function() require('dap').toggle_breakpoint() end
        '';
        options.desc = "[T]oggle [B]reakpoint";
      }
    ];
  };
}
