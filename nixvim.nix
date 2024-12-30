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

    # colorschemes.catppuccin = {
    #   enable = true;
    #   settings = {
    #     background.dark = "mocha";
    #     color_overrides = {
    #       mocha = {
    #         base = "#1b1b1b";
    #       };
    #     };
    #   };
    # };

    plugins = {
      bufferline.enable = true;

      blink-cmp = {
        enable = true;
        settings.keymap.preset = "super-tab";
      };

      cmp = {
        enable = false;
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

      conform-nvim = {
        enable = true;
        luaConfig.pre =
          #Lua
          "local slow_format_filetypes = {}";
        settings = {
          formatters_by_ft = let
            shFormatters = ["shellcheck" "shellharden" "shfmt"];
          in {
            sh = shFormatters;
            bash = shFormatters;
            hmtl = ["prettierd"];
            nix = ["alejandra"];
            javascript = ["biome"];
            typescriptreact = ["biome"];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save =
            # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                local function on_format(err)
                  if err and err:match("timeout$") then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                  end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
               end
            '';
          format_after_save =
            # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                return { lsp_fallback = true }
              end
            '';
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            alejandra.command = lib.getExe pkgs.alejandra;
            prettierd.command = lib.getExe pkgs.prettierd;
            biome.command = lib.getExe pkgs.biome;
            shellcheck.command = lib.getExe pkgs.shellcheck;
            shfmt.command = lib.getExe pkgs.shfmt;
            shellharden.command = lib.getExe pkgs.shellharden;
            squeeze_blanks.command = lib.getExe' pkgs.coreutils "cat";
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
          # python
          basedpyright.enable = true;
          ruff.enable = true;
          # lua
          lua_ls.enable = true;
          # webdev
          superhtml.enable = true;
          biome.enable = true;
          volar.enable = true;
          # java
          jdtls = {
            enable = true;
            extraOptions.init_options.jvm_args = ["-javaagent:${pkgs.lombok}/share/java/lombok.jar"];
          };
          # docker compose
          docker_compose_language_service = {
            enable = true;
            filetypes = ["yaml"];
          };
          # nix
          nil_ls.enable = true;
        };
      };

      nui.enable = true;

      nvim-autopairs.enable = true;

      nvim-surround.enable = true;

      oil.enable = true;

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
            files.excludeDirs = [".direnv"];
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

      ts-autotag.enable = true;

      typescript-tools.enable = true;

      undotree.enable = true;

      tmux-navigator.enable = true;

      web-devicons.enable = true;

      zen-mode.enable = true;
    };

    extraPlugins = with pkgs; [
      (vimUtils.buildVimPlugin {
        name = "gruvbox-material";
        src = pkgs.fetchFromGitHub {
          owner = "sainnhe";
          repo = "gruvbox-material";
          rev = "170148af9350f578f3623f810e54698fa1e5bdbf";
          hash = "sha256-qErvjgqqWaCFeC9rdKQIRoHPhIew7GLxoXXYcqUVlI0=";
        };
      })
      vimPlugins.nightfox-nvim
      vimPlugins.palette-nvim
      vimPlugins.oxocarbon-nvim
      vimPlugins.lush-nvim
      vimPlugins.zenbones-nvim
      vimPlugins.lazydev-nvim
    ];

    extraConfigLuaPost = ''
      local hour = tonumber(os.date("%H"))
      if hour >= 6 and hour < 18 then
        vim.o.background = "dark"
        vim.o.background = "light"
      else
        vim.o.background = "light"
        vim.o.background = "dark"
      end
    '';

    extraConfigLua = ''
      require("lazydev").setup()

      vim.cmd([[colo zenbones]])

      -- Workaround: https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
      for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
          local default_diagnostic_handler = vim.lsp.handlers[method]
          vim.lsp.handlers[method] = function(err, result, context, config)
              if err ~= nil and err.code == -32802 then
                  return
              end
              return default_diagnostic_handler(err, result, context, config)
          end
      end
    '';
  };

  home.packages = with pkgs; [lombok ripgrep];
}
