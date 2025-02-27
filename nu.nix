{config, ...}: {
  programs = {
    nushell = {
      enable = true;
      extraConfig = ''
        use std/util "path add"
        path add ${config.home.homeDirectory}/.nix-profile/bin
        path add /nix/var/nix/profiles/default/bin
      '';
    };

    direnv.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
  };
}
