{pkgs, ...}: {
  home.packages = [pkgs.klog-time-tracker];
  programs.zsh.shellAliases = {
    kle = "klog edit @work";
    klt = "klog total --diff --now @work";
  };
}
