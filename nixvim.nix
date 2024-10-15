{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      scrolloff = 4;
      signcolumn = "yes:1";
    };

    colorschemes.catppuccin = {
      enable = false;
      settings = {
        flavour = "mocha";
        integrations = {nvim_surround = true;};
      };
    };

    colorschemes.nightfox = {
      enable = true;
      flavor = "nightfox";
    };

    plugins = {
      bufferline.enable = true;

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

      fidget.enable = true;

      guess-indent.enable = true;

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

      hex.enable = true;

      intellitab.enable = true;

      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          lspBuf = {
            K = "hover";
            ga = "code_action";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gr = "rename";
            gt = "type_definition";
          };
        };
        servers = {
          nil-ls.enable = false;
          nixd.enable = true;
        };
      };

      lsp-format.enable = true;

      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            actionlint.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            yamllint.enable = true;
          };
          formatting = {
            alejandra.enable = true;
          };
        };
      };

      nvim-autopairs.enable = true;

      nvim-jdtls = {
        enable = true;
        cmd = ["${pkgs.jdt-language-server}/bin/jdtls" "-javaagent:${pkgs.lombok}/share/java/lombok.jar"];
        settings.java = {
          jdt.ls.lombokSupport.enabled = true;
        };
      };

      nvim-surround.enable = true;

      otter = {
        enable = true;
        settings.handle_leading_whitespace = true;
      };

      smart-splits = {
        enable = true;
        luaConfig.post = ''
          -- recommended mappings
          -- resizing splits
          -- these keymaps will also accept a range,
          -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
          vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
          vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
          vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
          vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
          -- moving between splits
          vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
          vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
          vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
          vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
          vim.keymap.set('n', '<C-->', require('smart-splits').move_cursor_previous)
          -- swapping buffers between windows
          vim.keymap.set('n', '<C-H>', require('smart-splits').swap_buf_left)
          vim.keymap.set('n', '<C-J>', require('smart-splits').swap_buf_down)
          vim.keymap.set('n', '<C-K>', require('smart-splits').swap_buf_up)
          vim.keymap.set('n', '<C-L>', require('smart-splits').swap_buf_right)
        '';
      };

      render-markdown.enable = true;

      rustaceanvim = {
        enable = true;
        settings.server.default_settings = {
          inlayHints.lifetimeElisionHints.enable = "always";
          rust-analyzer = {
            cargo = {allFeatures = true;};
            check = {command = "clippy";};
          };
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader><leader>" = {
            action = "git_files";
            options.desc = "Telescope git files";
          };
          "<leader>fg" = "live_grep";
        };
      };

      undotree.enable = true;

      web-devicons.enable = true;
    };
  };

  home.packages = with pkgs; [actionlint alejandra deadnix jdt-language-server lombok statix yamllint];
}
