{pkgs, ...}: let
  inherit (pkgs) openshift kubernetes-helm kubectl kustomize;
in {
  home.packages = [
    openshift
    kubectl
    kubernetes-helm
    kustomize
  ];

  programs.zsh.shellAliases = {
    oclogin = "oc login -u brua --server=https://api.okd.svc.elca.ch:6443";
    kc = "kubectl";
  };
}
