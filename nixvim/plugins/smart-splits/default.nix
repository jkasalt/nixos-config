{lib, ...}: let
  inherit (lib.nixvim) mkRaw;
  km = {
    key,
    action,
  }: {
    inherit key action;
    mode = "n";
    options = {
      silent = true;
      noremap = true;
    };
  };
in {
  plugins.smart-splits.enable = true;
  keymaps = [
    # resizing splits
    (km {
      key = "<A-h>";
      action = mkRaw ''require('smart-splits').resize_left'';
    })
    (km {
      key = "<A-j>";
      action = mkRaw ''require('smart-splits').resize_up'';
    })
    (km {
      key = "<A-k>";
      action = mkRaw ''require('smart-splits').resize_down'';
    })
    (km {
      key = "<A-l>";
      action = mkRaw ''require('smart-splits').resize_right'';
    })
    # moving between splits
    (km {
      key = "<C-h>";
      action = mkRaw "require('smart-splits').move_cursor_left";
    })
    (km {
      key = "<C-j>";
      action = mkRaw "require('smart-splits').move_cursor_down";
    })
    (km {
      key = "<C-k>";
      action = mkRaw "require('smart-splits').move_cursor_up";
    })
    (km {
      key = "<C-l>";
      action = mkRaw "require('smart-splits').move_cursor_right";
    })
    (km {
      key = "<C-->";
      action = mkRaw "require('smart-splits').move_cursor_previous";
    })
    # swapping buffers between splits
    (km {
      key = "<C-H>";
      action = mkRaw "require('smart-splits').swap_buf_left";
    })
    (km {
      key = "<C-J>";
      action = mkRaw "require('smart-splits').swap_buf_down";
    })
    (km {
      key = "<C-K>";
      action = mkRaw "require('smart-splits').swap_buf_up";
    })
    (km {
      key = "<C-L>";
      action = mkRaw "require('smart-splits').swap_buf_right";
    })
  ];
}
