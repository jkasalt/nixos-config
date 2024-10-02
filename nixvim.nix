{
  enable = true;

  opts = {number = true;};

  colorschemes.catppuccin.enable = true;

  plugins = {
    bufferline.enable = true;
    web-devicons.enable = true;
    guess-indent.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
  };

  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };

  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };
    servers = {
      nil-ls.enable = true;
    };
  };

  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {nix = ["alejandra"];};
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = "never";
      };
    };
  };
}
