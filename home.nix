{
  config,
  pkgs,
  username,
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

  imports = [./tmux.nix ./ssh.nix ./git.nix ./nixvim ./zsh.nix ./openshift.nix];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    taskwarrior3
    vit
    lazygit
    bat
    devenv
    fd
    gh
    jq
    jaq
    leetcode-cli
    nom
    python3
    cargo-generate
    xclip
    openssh
    nix-direnv
    yarn
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
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/luca/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs = {
    opam = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
