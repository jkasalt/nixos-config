{pkgs, ...}: {
  programs.fish = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
