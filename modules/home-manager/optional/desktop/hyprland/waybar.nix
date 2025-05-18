{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 10;
        margin-left = 20;
        margin-right = 20;
        margin-top = 20;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
          "hyprland/submap"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "disk"
          "memory"
          "cpu"
          # "network"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
        ];

        battery = {
          interval = 5;
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{power:.1f} W {time}";
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁  Connected";
          format-disconnected = "  Disconnected";
          on-click = "nm-connection-editor";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };

        pulseaudio = {
          format-source = "󰍬  {volume}%";
          format-source-muted = "󰍭  0%";
          format = "{icon}  {volume}% {format_source}";
          format-muted = "󰸈  0% {format_source}";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click-right = lib.getExe pkgs.pavucontrol;
          on-click = "pamixer -t";
          reverse-scrolling = true;
        };

        cpu = {
          format = "  {usage}%";
        };

        memory = {
          format = "  {}%";
          interval = 5;
        };

        tray = {
          icon-size = 12;
          spacing = 10;
          padding-right = 10;
        };

        clock = {
          interval = 1;
          format = "<b>{:%a %d. %b  %H:%M}</b>";
          format-alt = "<b>{:%d.%m.%Y  %H:%M:%S}</b>";
          on-click-left = "mode";
          tooltip-format = "{calendar}";
          calendar = {
            weeks-pos = "right";
            format = {
              today = "<span><b><u>{}</u></b></span>";
              weeks = "<span><b>{}</b></span>";
            };
          };
        };

        disk = {
          interval = 30;
          format = "  {percentage_used}%";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon}  {percent}%";
          format-icons = [""];
        };

        "hyprland/window" = {
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = "  $1";
            "(.*) - Visual Studio Code" = "󰨞  $1";
          };
        };

        "hyprland/workspaces" = {
          format = " {icon} {windows}";
          format-window-separator = "";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          window-rewrite-default = " ";
          window-rewrite = {
            "title<.*youtube.*>" = " ";
            "class<firefox>" = " ";
            "class<firefox> title<.*github.*>" = " ";
            "kitty" = " ";
            "code" = "󰨞 ";
            "spotify" = " ";
            "vesktop" = " ";
          };
        };
      };
    };
    # customize with "$ env GTK_DEBUG=interactive waybar"
    style = with config.lib.stylix.colors.withHashtag; ''
      @define-color base00 ${base00}; @define-color base01 ${base01}; @define-color base02 ${base02}; @define-color base03 ${base03};
      @define-color base04 ${base04}; @define-color base05 ${base05}; @define-color base06 ${base06}; @define-color base07 ${base07};

      @define-color base08 ${base08}; @define-color base09 ${base09}; @define-color base0A ${base0A}; @define-color base0B ${base0B};
      @define-color base0C ${base0C}; @define-color base0D ${base0D}; @define-color base0E ${base0E}; @define-color base0F ${base0F};

      * {
        border: solid;
        border-radius: 8px;
        background: transparent;
        font-family: "${config.stylix.fonts.sansSerif.name}";
        font-size: ${builtins.toString config.stylix.fonts.sizes.desktop}pt;
      }
      window#waybar, tooltip {
        background: alpha(@base00, ${builtins.toString config.stylix.opacity.desktop});
        color: @base05;
        border-radius: 8px;
      }
      tooltip label {
        color: @theme_text_color;
      }
      #workspaces button {
        background: @theme_base_color;
        margin: 5 3px;
        padding: 2 10px;
        border-radius: 8px
      }
      #workspaces button.active {
        border: none;
        background: linear-gradient(
            130deg,
            @base0E 20%,
            @base07
        );
        background-size: 100%;
        color: shade(@theme_text_color, 0.4);
      }
      #tray {
        padding-right: 8px;
      }
    '';
  };
}
