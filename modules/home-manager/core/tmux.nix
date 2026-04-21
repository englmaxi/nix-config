{
  config,
  lib,
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
      set -g clock-mode-style 24
      set -g mode-keys vi

      bind-key x kill-pane
      set -g detach-on-destroy off

      set -g display-panes-active-colour "${base08}"
      set -g display-panes-colour "${base02}"
      set -g pane-border-style "fg=${base01}"
      set -g pane-active-border-style "fg=${base01}"

      set -s escape-time 10
      set -sg repeat-time 600
      set -g renumber-windows on
      set -g status-style "fg=${base04},bg=${base00}"
      set -g window-status-style "fg=${base04},bg=${base00}"
      set -g window-status-current-style "fg=${base0A},bg=${base00}"
      set -g status-position bottom
      set -g status-justify left
      set -g status-right ' '
      set -g status-left '#[bold,bg=${base00},fg=${base01}]#[bg=${base01}]#[#{?client_prefix,fg=${base0E},fg=${base04}}]#{?client_prefix,,} #[fg=${base04}]#S#[bg=${base00},fg=${base01}] #[fg=${base01}]| '
      set -g status-left-length 100
      set -g window-status-current-format '#[bold,fg=${base01}]#[fg=${base0A},bg=${base01}]#I #[fg=${base0A},bg=${base00}] #W '
      set -g window-status-format '#[nobold,fg=${base01}]#[bg=${base01},fg=${base04}]#I  #W#[bg=${base00},fg=${base01}]'

      bind-key "${config.programs.sesh.tmuxKey}" run-shell "sesh connect \"$(
            sesh list --icons | fzf --tmux 80%,70% \
              --no-sort --ansi --border-label ' sesh ' --prompt '  ' \
              --header '  ^a , ^t , ^g , ^x , ^d , ^f , ^s ' \
              --bind 'tab:down,btab:up' \
              --bind 'ctrl-a:change-prompt(  )+reload(sesh list --icons)' \
              --bind 'ctrl-t:change-prompt(  )+reload(sesh list --icons -t)' \
              --bind 'ctrl-g:change-prompt(  )+reload(sesh list --icons -c)' \
              --bind 'ctrl-x:change-prompt(  )+reload(sesh list --icons -z)' \
              --bind 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
              --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(  )+reload(sesh list --icons)' \
              --bind 'ctrl-s:execute(tmuxinator new {2..} {2..})+change-prompt(  )+reload(sesh list --icons)' \
              --preview-window 'right:55%' \
              --preview 'sesh preview {}' \
              -- --ansi
          )\""
    '';
  };

  programs.fzf.tmux.enableShellIntegration = true;
  programs.sesh = {
    enable = true;
    enableTmuxIntegration = false;
    enableAlias = true;
    settings = {
      sort_order = ["tmux" "tmuxinator" "config" "zoxide"];
      default_session = {
        preview_command = "eza -1a --group-directories-first --git --icons --color=always {}";
      };
    };
  };

  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist".directories = [".config/tmuxinator"];
      };
    };
}
