{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "data";
        # https://gitlab.com/ntgn/ascii-art
        source = ''
               _   ___    _
              +o\  \  \  / \
              \oo\  \  \/  /
            ,oo+oo+oo\   ,/ +\
           <oooooooooo\  \ /os;
               /``/    \  ,oo/
          ,─~─'  /      \,oooooo,
          \__   ;s      /oo/sss>`
            /  /so\____/ss/____
           `, / \oo\   ```     /
            \/ /sooo\─~.  .─~─`
              /so/\oo\  \  \
              \o/  \s+\  \_/
                    ```
        '';
        padding.right = 2;
      };
      display = {
        key = {
          type = "both-2";
          width = 18;
        };
        separator = "";
      };
      modules = [
        {
          type = "title";
          format = "{user-name-colored}{#light_red}@{host-name-colored} {#}";
        }
        "separator"
        {
          type = "os";
          key = "System       ";
        }
        {
          type = "kernel";
          key = "Kernel       ";
        }
        {
          type = "shell";
          key = "Shell        ";
        }
        {
          type = "uptime";
          key = "Uptime       ";
        }
        {
          type = "wm";
          key = "Desktop      ";
        }
        {
          type = "cpu";
          showPeCoreCount = true;
          temp = true;
        }
        {
          type = "gpu";
          driverSpecific = true;
          temp = true;
        }
        {
          type = "memory";
          key = "Memory       ";
        }
        {
          type = "disk";
          key = "Storage (/)  ";
          folders = "/";
        }
        "separator"
        {
          type = "colors";
          keyIcon = "";
          symbol = "circle";
        }
      ];
    };
  };
}
