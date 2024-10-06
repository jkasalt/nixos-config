{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapLeader = " ";

    opts = {number = true;};

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          nvim_surround = true;
        };
      };
    };

    plugins = {
      bufferline.enable = true;
      web-devicons.enable = true;
      guess-indent.enable = true;
      nvim-autopairs.enable = true;
      nvim-surround.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

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

      cmp = {
        enable = true;
        settings = {
          sources = [
            # LSP
            {name = "nvim_lsp";}
            {name = "nvim_lsp_signature_help";}

            # Filesystem paths
            {name = "path";}

            # Buffer CMP
            {name = "buffer";}

            # Snippets
            {name = "snippy";}
            {name = "luasnip";}

            {name = "cmp-dap";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      lsp = {
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
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {nix = ["alejandra"];};
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = "never";
          };
        };
      };
    };
  };

  home.packages = with pkgs; [alejandra];
}
