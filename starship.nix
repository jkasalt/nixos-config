{ lib, ... }:
{
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
        style = "white";
        read_only = "󰌾";
      };

      character = {
        success_symbol = "[心:](white)";
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
        format = "[ $branch]($style) ";
        style = "purple";
      };

      git_status = {
        style = "bright-purple";
      };

      git_metrics = {
        disabled = false;
        added_style = "green";
        deleted_style = "red";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      nix_shell = {
        format = "[$state$symbol]($style)";
        impure_msg = " ";
        pure_msg = "( )";
        symbol = "";
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };
}
