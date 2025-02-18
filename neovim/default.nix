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

        autocomplete.blink-cmp.enable = true;

        autopairs.nvim-autopairs.enable = true;

        binds.whichKey.enable = true;

        git.enable = true;

        languages = {
          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;

          java.enable = true;
          nix.enable = true;
          rust.enable = true;
        };

        lazy.plugins = {
          "guess-indent.nvim" = {
            package = pkgs.vimPlugins.guess-indent-nvim;
            setupModule = "guess-indent";
          };
        };

        lsp = {
          formatOnSave = true;
          otter-nvim.enable = true;
          trouble.enable = true;
        };

        mini = {
          ai.enable = true;
          basics.enable = true;
          starter.enable = true;
          statusline.enable = true;
          tabline.enable = true;
          trailspace.enable = true;
        };

        telescope = {
          enable = true;
        };
      };
    };
  };
}
