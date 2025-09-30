{lib, ...}: let
  mkWindowRule = app: rule: map (r: "${r}, class:(${app})") rule;
  mkLayerRule = layer: rule: map (r: "${r}, ${layer}") rule;
in {
  wayland.windowManager.hyprland.settings = {
    layerrule = mkLayerRule "waybar" [
      "blur"
      "ignorezero"
    ];

    windowrule =
      mkWindowRule "clipse" [
        "float"
        "size 850 700"
        "stayfocused"
      ]
      ++ mkWindowRule "^(MEGAsync)$" [
        "float"
        "noborder"
        "noblur"
        "noshadow"
      ];
  };
}
