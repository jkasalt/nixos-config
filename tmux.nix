{pkgs, ...}: {
  programs.tmux = {
    baseIndex = 1;
    clock24 = true;
    enable = true;
    escapeTime = 10;
    extraConfig =
      # tmux
      ''
        set-option -sa terminal-overrides ",xterm*:Tc"
        set-option -g set-clipboard on
        set-option -g mouse on

        bind -n M-H previous-window
        bind -n M-L next-window

        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      yank
    ];
    prefix = "C-Space";
    terminal = "screen-256color";
  };
}
