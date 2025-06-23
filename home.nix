{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  imports = [
    ./tmux.nix
    ./taskwarrior.nix
    ./ssh.nix
    ./git.nix
    ./klog.nix
    ./nu.nix
    ./openshift.nix
    ./zsh.nix
    ./zellij.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    inputs.nvim-flake.packages.${pkgs.stdenv.system}.default
    bat
    comma
    docker
    fd
    hledger
    ihp-new
    jq
    just
    klog-time-tracker
    lazygit
    nix-direnv
    openssh
    ripgrep
    ripgrep-all
    xclip
    websocat
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (writeShellScriptBin "task-git-sync" ''
      #!/usr/bin/env bash

      cd ~/.task/json || exit 1
      task export >all.json
      git add all.json
      git commit -m "$(date)"
      git push
    '')
    (writeShellScriptBin "notes" ''
      #!/usr/bin/env bash

      TODAY=$(date -I)
      FILENAME="notes-$TODAY.md"
      nvim ~/notes/$FILENAME
    '')
    (writeShellScriptBin "journal" ''
      #!/usr/bin/env bash

      TODAY=$(date -I)
      FILENAME="$TODAY.md"
      nvim ~/journal/$FILENAME
    '')
    (writeShellScriptBin "nixcfg" ''
      #!/usr/bin/env bash
      cd ${config.home.homeDirectory}/nixos-config || exit 1 # how to make this more robust?
      ''$SHELL
      git add .
      git commit
    '')
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs = {
    zk.enable = true;
    helix.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
