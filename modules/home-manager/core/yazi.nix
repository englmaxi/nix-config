{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    plugins = {
      git = pkgs.yaziPlugins.git;
      ouch = pkgs.yaziPlugins.ouch;
      bypass = pkgs.yaziPlugins.bypass;
      duckdb = pkgs.yaziPlugins.duckdb;
      mediainfo = pkgs.yaziPlugins.mediainfo;
    };
  };
}
