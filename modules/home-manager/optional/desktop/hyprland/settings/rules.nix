{lib, ...}: let
  mkWindowRule = app: rule: map (r: "${r}, ${app}") rule;
  mkLayerRule = layer: rule: map (r: "${r}, ${layer}") rule;
in {
  wayland.windowManager.hyprland.settings = {
    layerrule =
      mkLayerRule "match:namespace waybar" [
        "blur on"
        "ignore_alpha 0"
      ]
      ++ mkLayerRule "match:namespace rofi" [
        "blur on"
        "ignore_alpha 0"
      ];

    windowrule =
      mkWindowRule "match:class .*" [
        "suppress_event maximize"
      ]
      ++ mkWindowRule "match:float true" [
        "max_size 1200 800"
        "center on"
      ]
      ++ mkWindowRule "match:class clipse" [
        "float on"
        "size 850 700"
        "stay_focused on"
      ]
      ++ mkWindowRule "match:class ^(Gimp)$" [
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "match:class ^(MEGAsync)$" [
        "float on"
        "border_size 0"
        "no_blur on"
        "no_shadow on"
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "match:class ^(MEGAsync)$, match:title ^(Add sync)$" [
        "float on"
        "size 800 600"
        "center on"
        "no_focus on"
        "border_size 0"
        "no_blur on"
        "no_shadow on"
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "match:title ^(Picture-in-Picture)$" [
        "float on"
        "pin on"
        "size 270 204"
        "move 100%-270 100%-204"
        "border_size 0"
        "no_initial_focus on"
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "match:class ^(org.pulseaudio.pavucontrol)$" [
        "float on"
        "size 1200 800"
        "stay_focused on"
        "dim_around on"
        "center on"
      ];

    workspace = [
      "s[true], gapsout:80"

      "special:scratchpad, on-created-empty:$terminal"
      "special:spotify,    on-created-empty:spotify"

      "w[tv1]s[false]m[DP-2], gapsout:20 520"
    ];
  };
}
