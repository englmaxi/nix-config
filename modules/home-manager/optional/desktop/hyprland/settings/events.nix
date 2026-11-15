{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    workspace_programs = {
      _var = {
        "special:scratchpad" = ["kitty"];
        "special:spotify" = ["spotify"];
      };
    };
    on = [
      {
        _args = [
          "workspace.created"
          (lib.generators.mkLuaInline ''
            function(ws)
                if not ws.is_empty then return end

                -- use programs associated with window id by default
                local program = ws.id and workspace_programs[tostring(ws.id)]
                    or workspace_programs[ws.name]
                if program == nil then return end

                local cmd, provided_rules = table.unpack(program)
                -- shallow-copy the rules table so we can add the workspace to it
                local rules = {}
                if provided_rules ~= nil then
                    for k, v in provided_rules do rules[k] = v end
                end
                -- force program to open on desired workspace, even if focus is moved to another
                -- workspace before the program window appears
                rules.workspace = (ws.id and tostring(ws.id) or ws.name) .. " silent"
                -- run it!
                hl.exec_cmd(cmd, rules)
            end
          '')
        ];
      }
    ];
  };
}
