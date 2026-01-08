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
      mkWindowRule "floating:1" [
        "maxsize 1200 800"
        "center 1"
      ]
      ++ mkWindowRule "class:clipse" [
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
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "class:^(MEGAsync)$,title:^(Add sync)$" [
        "float"
        "size 800 600"
        "center"
        "nofocus"
        "noborder"
        "noblur"
        "noshadow"
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "title:^(Picture-in-Picture)$" [
        "float"
        "pin"
        "size 270 204"
        "move 100%-270 100%-204"
        "noborder"
        "noinitialfocus"
        "opacity 1.0 override"
      ]
      ++ mkWindowRule "class:^(org.pulseaudio.pavucontrol)$" [
        "float"
        "size 45%"
        "center"
      ];

    workspace = [
      "s[true], gapsout:60"

      "special:scratchpad, on-created-empty:$terminal"
      "special:spotify,    on-created-empty:spotify"
    ];
  };
}
