_: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/zellij/config.kdl".source = ./dotfiles/zellij/config.kdl;
}
