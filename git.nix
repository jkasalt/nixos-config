{
  enable = true;
  delta.enable = true;
  extraConfig = {
    branch . sort = "-commiterdate";
    column.ui = "auto";
    diff.colorMoved = "default";
    diff.algorithm = "histogram";
    merge.conflictStyle = "diff3";
    merge.tool = "nvimdiff4";
    mergetool."nvimdiff4" = {
      cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
    };
    rerere.enabled = true;
    pull.rebase = true;
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
  };
}
