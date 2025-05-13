{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        autocomplete.nvim-cmp.enable = true;

        autopairs.nvim-autopairs.enable = true;

        binds.whichKey.enable = true;

        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };

        git = {
          enable = true;
          git-conflict.enable = true;
        };

        hideSearchHighlight = true;

        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;
          bash.enable = true;
          haskell.enable = true;
          helm.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python.enable = true;
          rust = {
            enable = true;
            lsp.opts =
              # lua
              ''
                ["rust-analyzer"] = {
                  cargo = {allFeatures = true};
                  check = {command = "clippy"};
                  files = {excludeDirs = {".direnv"}};
                }
              '';
          };
          yaml.enable = true;
        };

        extraPlugins = with pkgs.vimPlugins; {
          vscode-nvim = {
            package = vscode-nvim;
            setup =
              # lua
              ''
                require("vscode").setup({
                  italic_comments = true,
                })
                vim.cmd.colorscheme("vscode")
              '';
          };
          vim-klog = {
            package = pkgs.fetchFromGitHub {
              owner = "73";
              repo = "vim-klog";
              rev = "ca32b78e7e90095552f37197b4f9eb0ae99b3000";
              hash = "sha256-89zkZWmyF+xQNHJAfmAfA0HVJpKPWt1jMgN8NifoQws=";
            };
          };
        };

        lazy.plugins = with pkgs.vimPlugins; {
          "guess-indent.nvim" = {
            package = guess-indent-nvim;
            setupModule = "guess-indent";
          };
          "telescope-ui-select.nvim" = {
            package = telescope-ui-select-nvim;
            after =
              #lua
              ''require("telescope").load_extension("ui-select")'';
          };
          zk-nvim = {
            package = zk-nvim;
            setupModule = "zk";
            ft = "markdown";
          };
        };

        diagnostics = {
          enable = true;
          config.virtual_text = true;
        };

        lsp = {
          formatOnSave = true;
          lspkind.enable = true;
          nvim-docs-view.enable = true;
          otter-nvim.enable = true;
          trouble.enable = true;
        };

        notes.neorg = {
          enable = true;
          treesitter.enable = true;
          setupOpts.load."core.defaults".enable = true;
        };

        mini = {
          ai.enable = true;
          basics.enable = true;
          bracketed.enable = true;
          extra.enable = true;
          move.enable = true;
          operators.enable = true;
          starter.enable = true;
          statusline.enable = true;
          surround.enable = true;
          tabline.enable = true;
          trailspace.enable = true;
        };

        options = {
          scrolloff = 6;
        };

        telescope = {
          enable = true;
        };

        terminal.toggleterm.enable = true;

        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
          # grammars = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.builtGrammars;
          grammars = [pkgs.vimPlugins.nvim-treesitter.builtGrammars.xml];
        };

        utility.oil-nvim = {
          enable = true;
          setupOpts = {
            skip_confirm_for_simple_edits = true;
            watch_for_changes = true;
          };
        };

        visuals.fidget-nvim.enable = true;
      };
    };
  };
}
