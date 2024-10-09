_: {
  imports = [./starship.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    antidote = {
      enable = true;
      plugins = ["Aloxaf/fzf-tab kind:defer"];
    };
    history = {
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';

    shellAliases = {
      g = "git";
      us = "systemctl --user"; # mnemonic for user systemctl
      rs = "sudo systemctl"; # mnemonic for root systemctl
    };
  };

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
