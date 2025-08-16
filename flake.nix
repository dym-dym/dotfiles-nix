{
  description = "Dymdym's dotfiles";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix/release-25.05";

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, ... }@inputs: # nixos-hardware,
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
            # nixos-hardware.nixosModules.gigabyte-b550
            # inputs.stylix.nixosModules.stylix
            inputs.sddm-sugar-candy-nix.nixosModules.default
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                    # legacyPackages.${prev.system};
                  };
                })
              ];
            }
          ];
        };
      };

      homeConfigurations = {
        dymdym = home-manager.lib.homeManagerConfiguration {
	        inherit pkgs;

          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./user/home.nix
            inputs.stylix.homeModules.stylix
            inputs.hyprland.homeManagerModules.default
            # inputs.nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}
