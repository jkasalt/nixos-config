{pkgs, ...}: {
  home.packages = [pkgs.klog-time-tracker];
  programs.zsh.shellAliases = {
    kle = "klog edit @work";
    klc = "klog tags --today @work"; # like kl "count"
    klt = "klog today --diff --now @work";
  };
}
