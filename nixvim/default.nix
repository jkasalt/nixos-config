{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./options.nix
    ./keymaps.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    imports = lib.attrsets.foldlAttrs (
      prev: name: type:
        prev ++ lib.lists.optional (type == "directory") (./plugins + "/${name}")
    ) [] (builtins.readDir ./plugins);

    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.tokyonight.enable = true;

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

      trouble.enable = true;

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
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
        name = "falcon";
        src = pkgs.fetchFromGitHub {
          owner = "fenetikm";
          repo = "falcon";
          rev = "a7f5d325ebdad20c8b74ebe4f4fede8d451ac1dd";
          hash = "sha256-ihlXhQ1hFQXuv+X6eKQ+AbHnUz8O/06BQEuIh4CNksI=";
        };
      })
      vimPlugins.nightfox-nvim
      vimPlugins.palette-nvim
      vimPlugins.oxocarbon-nvim
      # vimPlugins.lush-nvim
      vimPlugins.zenbones-nvim
      vimPlugins.lazydev-nvim
      vimPlugins.leetcode-nvim
    ];

    extraConfigLua = ''
      require("lazydev").setup()
      require("leetcode").setup()
    '';
  };

  home.packages = with pkgs; [lombok ripgrep];
}
