{pkgs, ...}: {
  home.packages = [pkgs.klog-time-tracker];
  programs.zsh.shellAliases = {
    kle = "klog edit @work";
    klc = "klog tags --today @work"; # like kl "count"
    klt = "klog today --diff --now @work";
  };
  programs.zsh.initExtra = "source <(klog completion -c zsh)";
}
