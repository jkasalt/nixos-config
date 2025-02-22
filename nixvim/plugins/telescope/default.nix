_: {
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };
    keymaps = {
      "<leader><leader>" = {
        action = "fd";
        options.desc = "Telescope find files";
      };
      "<leader>fg" = "live_grep";
    };
  };
}
