{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];

  programs.nixvim = {
    imports = let
      plugins = lib.attrsets.foldlAttrs (
        prev: name: type:
          prev ++ lib.lists.optional (type == "directory") (./plugins + "/${name}")
      ) [] (builtins.readDir ./plugins);
    in
      plugins ++ [./options.nix ./keymaps.nix];

    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.tokyonight.enable = true;

    extraPlugins = with pkgs; [
      vimPlugins.lazydev-nvim
    ];

    extraConfigLua = ''
      require("lazydev").setup()
    '';
  };
}
