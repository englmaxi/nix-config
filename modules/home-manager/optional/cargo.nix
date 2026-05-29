{config, ...}: {
  programs.cargo = {
    enable = true;
    package = null;
    cargoHome = "${config.xdg.dataHome}/cargo";
    settings.alias = {
      b = "build";
      c = "check";
      d = "doc";
      t = "test";
      r = "run";
      rr = "run --release";
      lint = "clippy --all-targets --all-features -- -W clippy::pedantic -W clippy::nursery";
    };
  };
}
