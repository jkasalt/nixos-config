{
  pkgs,
  lib,
  ...
}: {
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
      wrap = false;
    };

    colorschemes.catppuccin.enable = true;

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

      dap.enable = true;

      fidget.enable = true;

      guess-indent.enable = true;

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

      hex.enable = true;

      intellitab.enable = true;

      lint = {
        enable = true;
        lintersByFt = {
          nix = ["statix"];
        };
        linters = {
          statix.cmd = lib.getExe pkgs.statix;
        };
      };

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
          basedpyright.enable = true;
          lua_ls.enable = true;
          ruff.enable = true;
          tinymist.enable = true;
          jdtls = {
            enable = true;
            extraOptions.init_options.jvm_args = ["-javaagent:${pkgs.lombok}/share/java/lombok.jar"];
          };
          docker_compose_language_service = {
            enable = true;
            filetypes = ["yaml"];
          };
          nixd.enable = true;
        };
      };

      lsp-format.enable = true;

      none-ls = {
        enable = true;
        sources = {
          code_actions = {
            statix.enable = true;
          };
          diagnostics = {
            actionlint.enable = true;
            # sqruff.enable = true;
            statix.enable = true;
            tidy.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            biome.enable = true;
            # sqruff.enable = true;
            typstyle.enable = true;
          };
        };
      };

      nui.enable = true;

      nvim-autopairs.enable = true;

      nvim-surround.enable = true;

      otter = {
        enable = true;
        settings.handle_leading_whitespace = true;
      };

      smart-splits = {
        enable = true;
        luaConfig.post =
          # Lua
          ''
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
        extensions.fzf-native.enable = true;
        keymaps = {
          "<leader><leader>" = {
            action = "fd";
            options.desc = "Telescope find files";
          };
          "<leader>fg" = "live_grep";
        };
      };

      undotree.enable = true;

      tmux-navigator.enable = true;

      web-devicons.enable = true;
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "leetcode";
        src = pkgs.fetchFromGitHub {
          owner = "kawre";
          repo = "leetcode.nvim";
          rev = "6a2e54ff13027fb3ce46b61a0e721eccc020ec80";
          hash = "sha256-jLuqsUnEgPFCp97G5sDqP4+DfIWc/uy0a6oTkMIXXtE=";
        };
      })
    ];
    extraConfigLua = ''
      require("leetcode").setup({
        lang = "python3",
      })
    '';
  };

  home.packages = with pkgs; [lombok];
}
