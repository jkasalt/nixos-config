{pkgs, ...}: {
  home.packages = [pkgs.klog-time-tracker];
  programs.zsh.shellAliases = {
    kle = "klog edit @work";
    klc = "klog total --diff --now @work"; # like kl "count"
    klt = "klog today --diff --now @work";
  };
}
