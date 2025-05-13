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
  enable = {
    enable = true;
    enableZshIntegration = true;
  };
in {
  imports = [./starship.nix];

  programs = {
    zsh = zshConfig;

    atuin = enable;

    zoxide =
      {
        options = ["--cmd cd"];
      }
      // enable;

    fzf = enable;

    direnv =
      {
        nix-direnv.enable = true;
      }
      // enable;

    carapace = enable;
  };
}
