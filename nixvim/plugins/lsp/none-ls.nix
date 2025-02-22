_: {
  plugins.none-ls = {
    enable = true;
    sources = {
      code_actions = {
        statix.enable = true;
      };
      diagnostics = {
        actionlint.enable = true;
        hadolint.enable = true;
        # sqruff.enable = true;
        statix.enable = true;
        tidy.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        typstyle.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
}
