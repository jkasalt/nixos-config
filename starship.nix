{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$aws"
        "$azure"
        "$gcloud"
        "$line_break"
        "$battery"
        "$python"
        "$nix_shell"
        "$character"
      ];
      right_format = lib.concatStrings ["$cmd_duration"];

      directory.style = "bold green";
      directory.read_only = " 󰌾";

      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](purple)";
      };

      battery.display = [
        {
          threshold = 10;
          style = "bold red";
        }
        {
          threshold = 30;
          style = "bold yellow";
        }
      ];

      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      nix_shell = {
        format = "[$state$symbol]($style)";
        impure_msg = "!";
        pure_msg = "";
        symbol = " ";
        heuristic = true;
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };
}
