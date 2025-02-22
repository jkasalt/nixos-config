_: {
  plugins = {
    fugitive.enable = true;

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          ignore_whitespace = true;
        };
        diff_opts = {
          algorithm = "histogram";
          indent_heuristic = true;
        };
      };
    };
  };
}
