{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = "a";
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    plugins = builtins.attrValues {
      inherit
        (pkgs.tmuxPlugins)
        sensible
        yank
        copycat
        ;
    };
    extraConfig = ''
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind > swap-pane -D
      bind < swap-pane -U
      bind c new-window -c "#{pane_current_path}"

      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set -s escape-time 10
      set -sg repeat-time 600
      set -g renumber-windows on
      set -g status-justify centre
      set -g status-right '%Y-%m-%d %H:%M '
    '';
  };
}
