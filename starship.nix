{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$aws"
        "$azure"
        "$gcloud"
        "$username"
        "$hostname"
        "$directory"
        "$battery"
        "$python"
        "$character"
      ];

      right_format = lib.concatStrings [
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$git_metrics"
      ];

      aws = {
        format = "[$symbol($profile) \(($region)\) ($duration)]($style)";
      };

      directory = {
        read_only = "󰌾";
      };

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
        format = "[$branch]($style) ";
        style = "bright-purple";
      };

      git_metrics.disabled = false;

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
