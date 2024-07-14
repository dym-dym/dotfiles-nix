{
  description = "Dymdym's dotfiles";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      # Optional, by default this flake follows nixpkgs-unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs; };
	        inherit system;
          modules = [ 
            ./system/configuration.nix 
            nixos-hardware.nixosModules.lenovo-thinkpad-t590
            inputs.sddm-sugar-candy-nix.nixosModules.default
            {
              nixpkgs = {
                overlays = [
                  inputs.sddm-sugar-candy-nix.overlays.default
                ];
              };
            }
            # inputs.stylix.nixosModules.stylix
          ];
        };
      };

      homeConfigurations = {
        dymdym = home-manager.lib.homeManagerConfiguration {
	        inherit pkgs;
          modules = [ 
            ./user/home.nix 
            inputs.stylix.homeManagerModules.stylix
          ];
        };       
      };
    };
}
