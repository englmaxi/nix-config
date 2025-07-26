{...}:{
  programs.nixvim.plugins.gitblame = {
    enable = true;
    settings = {
      virtual_text_column = 80;
      date_format = "%r • %d %b %Y • %H:%M";
    };
  };
}
