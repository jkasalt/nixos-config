{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
        };

        autocomplete.blink-cmp = {
          enable = true;
          mappings = {
            confirm = "<C-y>";
            next = "<Down>";
            previous = "<Up>";
          };
          setupOpts.keymap.preset = "default";
        };

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
          html.enable = true;
          java.enable = true;
          markdown.enable = true;
          nix.enable = true;
          nu.enable = true;
          rust = {
            enable = true;
            lsp.opts = {
              cargo = {allFeatures = true;};
              check = {command = "clippy";};
              files.excludeDirs = [".direnv"];
            };
          };
          sql.enable = true;
          tailwind.enable = true;
          ts.enable = true;
        };

        lazy.plugins = with pkgs.vimPlugins; {
          "guess-indent.nvim" = {
            package = guess-indent-nvim;
            setupModule = "guess-indent";
          };
          "oil.nvim" = {
            package = oil-nvim;
            setupModule = "oil";
            setupOpts = {
              skip_confirm_for_simple_edits = true;
              watch_for_changes = true;
            };
            cmd = "Oil";
            keys = [
              {
                key = "<leader>-";
                mode = "n";
                action = ":Oil<CR>";
              }
            ];
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

        lsp = {
          formatOnSave = true;
          lsplines.enable = true;
          otter-nvim.enable = true;
          trouble.enable = true;
        };

        mini = {
          ai.enable = true;
          basics.enable = true;
          bracketed.enable = true;
          extra.enable = true;
          move.enable = true;
          operators.enable = true;
          pairs.enable = true;
          starter.enable = true;
          statusline.enable = true;
          surround.enable = true;
          tabline.enable = true;
          trailspace.enable = true;
        };

        notes.neorg = {
          enable = true;
          treesitter.enable = true;
          setupOpts.load = {
            "core.defaults" = {};
            "core.concealer" = {};
          };
        };

        telescope = {
          enable = true;
        };

        terminal.toggleterm.enable = true;
      };
    };
  };
}
