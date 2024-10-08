{pkgs, ...}: let
  inherit (pkgs) openshift;
in {
  home.packages = [
    openshift
  ];

  programs.zsh.initExtra = ''
    autoload -Uz compinit
    compinit
    if [ $commands[${openshift}/bin/oc] ]; then
      source <(${openshift}/bin/oc completion zsh)
      compdef _oc ${openshift}/bin/oc
    fi
  '';
}
