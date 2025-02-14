{lib, ...}: let
  helpers = lib.nixvim;
  inherit (helpers) mkRaw;
in {
  plugins.snacks.settings.bufdelete.enabled = true;
  userCommands = {
    Bd = {
      command = mkRaw ''
        function()
          Snacks.bufdelete()
        end
      '';
    };
    Bdo = {
      command = mkRaw ''
        function()
          Snacks.bufdelete.other()
        end
      '';
    };
  };
}
