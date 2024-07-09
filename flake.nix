{
  description = "Dymdym's dotfiles";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager , ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
	  inherit system;
          modules = [ ./system/configuration.nix ];
        };
      };

      homeConfigurations = {
        dymdym = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
          modules = [ ./user/home.nix ];
        };       
      };
    };
}
