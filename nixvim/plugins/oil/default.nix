_: {
  plugins.oil.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>-";
      action = "<cmd>Oil<CR>";
      options = {
        silent = true;
        desc = "Oil";
      };
    }
  ];
}
