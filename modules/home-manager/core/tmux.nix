{
  config,
  pkgs,
  ...
}: {
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
    tmuxinator.enable = true;
    extraConfig = with config.lib.stylix.colors.withHashtag; ''
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind > swap-pane -D
      bind < swap-pane -U
      bind c new-window -c "#{pane_current_path}"

      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
      set -g mode-keys vi

      set -s escape-time 10
      set -sg repeat-time 600
      set -g renumber-windows on
      set -g status-style "fg=${base04},bg=${base00}"
      set -g window-status-style "fg=${base04},bg=${base00}"
      set -g window-status-current-style "fg=${base0A},bg=${base00}"
      set -g status-position bottom
      set -g status-justify left
      set -g status-right ' '
      set -g status-left '#[bg=${base00},fg=${base01}]#[bold,fg=${base04},bg=${base01}] #S#[bg=${base00},fg=${base01}]   '
      set -g status-left-length 100
      set -g window-status-current-format '#[bold,fg=${base01}]#[fg=${base0A},bg=${base01}]#I #[fg=${base0A},bg=${base00}] #W '
      set -g window-status-format '#[nobold,fg=${base01}]#[bg=${base01},fg=${base04}]#I  #W#[bg=${base00},fg=${base01}]'
    '';
  };

  programs.fzf.tmux.enableShellIntegration = true; # needed for sesh
  programs.sesh = {
    enable = true;
    enableTmuxIntegration = true;
    enableAlias = true;
    settings = {
      sort_order = ["tmux" "tmuxinator" "config" "zoxide"];
      default_session = {
        preview_command = "eza -1a --group-directories-first --git --icons --color=always {}";
      };
    };
  };
}
