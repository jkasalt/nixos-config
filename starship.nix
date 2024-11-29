{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$aws"
        "$azure"
        "$gcloud"
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
