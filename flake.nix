{
  description = "Dymdym's dotfiles";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-26.05";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {

          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };

	        inherit system;

          modules = [
            ./system/configuration.nix
            # inputs.stylix.nixosModules.stylix
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                })
              ];
            }
          ];
        };
      };
      nixConfig = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };

      homeConfigurations = {
        dymdym = home-manager.lib.homeManagerConfiguration {
	        inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };

          modules = [
            ./user/home.nix
            inputs.stylix.homeModules.stylix
            inputs.niri.homeModules.niri
            inputs.noctalia.homeModules.default
            inputs.nixvim.homeModules.nixvim
          ];
        };
      };
    };
}
