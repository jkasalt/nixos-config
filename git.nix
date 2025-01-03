_: {
  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options.side-by-side = true;

    extraConfig = {
      branch.sort = "-committerdate";
      column.ui = "auto";
      diff = {
        colorMoved = "default";
        algorithm = "histogram";
        renames = "copies";
      };
      merge.conflictStyle = "diff3";
      merge.tool = "nvimdiff4";

      mergetool.nvimdiff4 = {
        cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
      };

      rerere.enabled = true;
      pull.rebase = false;
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };

    # Thank you: https://github.com/fufexan/dotfiles/blob/main/home/terminal/programs/git.nix
    aliases = let
      log = "log --show-notes='*' --abbrev-commit --pretty=format:'%Cred%h %Cgreen(%aD)%Creset -%C(bold red)%d%Creset %s %C(bold blue)<%an>% %Creset' --graph";
    in {
      a = "add --patch"; # make it a habit to consciosly add hunks
      ad = "add";

      b = "branch";
      ba = "branch -a"; # list remote branches
      bd = "branch --delete";
      bdd = "branch -D";

      c = "commit";
      ca = "commit --amend";
      cm = "commit --message";

      cl = "clone";

      d = "diff";
      ds = "diff --staged";

      h0 = "show";
      h1 = "show HEAD^";
      h2 = "show HEAD^^";
      h3 = "show HEAD^^^";
      h4 = "show HEAD^^^^";
      h5 = "show HEAD^^^^^";

      m = "merge";
      ma = "merge --abort";
      mc = "merge --continue";

      p = "push";
      pf = "push --force-with-lease";

      pl = "pull";

      l = log;
      lp = "${log} --patch";
      la = "${log} --all";

      rs = "restore";
      rsp = ''
        !f() { git restore --source="$1" --patch "$2"; }; f;
      '';
      rsh = "reset --hard";

      sw = "switch";
      sc = "switch -c";

      s = "status --short --branch";
      ss = "status";

      st = "stash";
      stc = "stash clear";
      sth = "stash show --patch";
      stl = "stash list";
      stp = "stash pop";

      forgor = "commit --amend --no-edit";
      oops = "restore";
    };

    userEmail = "lucabr123@gmail.com";
    userName = "Luca Bracone";
  };
}
