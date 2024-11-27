{
  description = "My NixOS WSL Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    homeConfig = username:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [./home.nix inputs.nixvim.homeManagerModules.nixvim];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {inherit username;};
      };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.nixos-wsl.nixosModules.default
        {system.stateVersion = "23.11";}
        ./configuration.nix
      ];
    };

    homeConfigurations = {
      desktop = homeConfig "nixos";
      laptop = homeConfig "brua";
    };
  };
}
