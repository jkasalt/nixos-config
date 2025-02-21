{pkgs, ...}: {
  home.packages = with pkgs; [taskwarrior3 timewarrior];
  home.file = {
    ".config/task/taskrc".source = ./dotfiles/taskrc;
    ".config/timewarrior" = {
      source = ./dotfiles/timewarrior;
      recursive = true;
    };
  };
}
