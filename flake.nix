{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-wallpaper.url = "github:lunik1/nix-wallpaper";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
#        inputs.nvf.homeManagerModules.default
        #inputs.nix-wallpaper.packages."x86_64-linux".default
      ];
    };
  };
}
