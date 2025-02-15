_: {
  plugins = {
    rustaceanvim = {
      enable = true;
      settings.server.default_settings = {
        inlayHints.lifetimeElisionHints.enable = "always";
        rust-analyzer = {
          cargo = {allFeatures = true;};
          check = {command = "clippy";};
          files.excludeDirs = [".direnv"];
        };
      };
    };
  };
}
