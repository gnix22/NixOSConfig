{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      ovata = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ 
          ./hosts/ovata.nix
        ];
      };
      grandiflora = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [

        ];
      };
    };
  };
}
