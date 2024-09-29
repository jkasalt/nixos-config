{
  description = "My NixOS WSL Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    	system = "x86_64-linux";
	modules = [
		inputs.nixos-wsl.nixosModules.default {system.stateVersion = "23.11";}
		./configuration
	];
    };
  };
}
