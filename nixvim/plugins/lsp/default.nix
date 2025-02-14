_: {
  imports = [./lsp.nix ./none-ls.nix];
  plugins = {
    fidget.enable = true;
    lsp-format.enable = true;

    otter = {
      enable = true;
      settings.handle_leading_whitespace = true;
    };
  };
}
