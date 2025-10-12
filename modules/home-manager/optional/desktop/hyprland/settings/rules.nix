{lib, ...}: let
  mkWindowRule = app: rule: map (r: "${r}, ${app}") rule;
  mkLayerRule = layer: rule: map (r: "${r}, ${layer}") rule;
in {
  wayland.windowManager.hyprland.settings = {
    layerrule =
      mkLayerRule "waybar" [
        "blur"
        "ignorezero"
      ]
      ++ mkLayerRule "rofi" [
        "blur"
        "ignorealpha"
      ];

    windowrule =
      mkWindowRule "class:clipse" [
        "float"
        "size 850 700"
        "stayfocused"
      ]
      ++ mkWindowRule "class:^(Gimp)$" [
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "class:^(MEGAsync)$" [
        "float"
        "noborder"
        "noblur"
        "noshadow"
      ]
      ++ mkWindowRule "title:^(Picture-in-Picture)$" [
        "float"
        "pin"
        "size 270 204"
        "move 100%-270 100%-204"
        "noborder"
        "noinitialfocus"
        "opacity 1.0 override"
      ];

    workspace = [
      "special:scratchpad, on-created-empty:$terminal"
      "special:scratchpad, gapsout:100"
    ];
  };
}
