{config, ...}: let
  zshConfig = {
    enable = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    history = {
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    shellAliases = let
      gitAliases = config.programs.git.aliases;
      gitShellAliases = builtins.listToAttrs (map (key: {
        name = "g${key}";
        value = "git ${gitAliases.${key}}";
      }) (builtins.attrNames gitAliases));
    in
      {
        g = "git";
        us = "systemctl --user"; # mnemonic for user systemctl
        rs = "sudo systemctl"; # mnemonic for root systemctl
      }
      // gitShellAliases;
  };
in {
  imports = [./starship.nix];
  home.shell.enableShellIntegration = true;

  programs = {
    zsh = zshConfig;

    atuin.enable = true;

    zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    fzf.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    carapace.enable = true;
  };
}
