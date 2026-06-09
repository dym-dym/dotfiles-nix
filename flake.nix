{
  description = "Dymdym's dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix/release-25.11";

    # sddm-sugar-candy-nix = {
    #   url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    niri,
    noctalia,
    # nixos-hardware,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        inherit system;

        modules = [
          ./system/configuration.nix
            # nixos-hardware.nixosModules.lenovo-thinkpad-t590
          # inputs.sddm-sugar-candy-nix.nixosModules.default
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
        ];
      };
    };
  };
}
