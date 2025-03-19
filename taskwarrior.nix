{pkgs, ...}: {
  home.packages = with pkgs; [python3 taskwarrior3 timewarrior];
  home.file = {
    ".config/task/taskrc".source = ./dotfiles/taskrc;
    ".config/timewarrior" = {
      source = ./dotfiles/timewarrior;
      recursive = true;
    };
    ".config/task/hooks/on-modify.timewarrior" = {
      source = "${pkgs.timewarrior}/share/doc/timew/ext/on-modify.timewarrior";
      executable = true;
    };
  };
}
