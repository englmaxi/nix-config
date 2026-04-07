{...}: {
  programs.sesh = {
    enable = true;
    enableTmuxIntegration = true;
    enableAlias = true;
  };
  programs.fzf.tmux.enableShellIntegration = true;
}
