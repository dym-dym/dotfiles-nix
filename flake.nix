{
  description = "Dymdym's dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix.url = "github:danth/stylix/release-26.05";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";

    preservation.url = "github:nix-community/preservation";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hermes-agent.url = "github:NousResearch/hermes-agent";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = nixpkgs-unstable.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets.json");
  in {
    nixosConfigurations = {
      void = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        inherit system;

        modules = [
          ./hosts/void
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.default
          ./hosts/void/preservation.nix
          ./hosts/void/disko.nix
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

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dymdym = import ./home;

              sharedModules = [
                inputs.stylix.homeModules.stylix
                inputs.niri.homeModules.niri
                inputs.noctalia.homeModules.default
                inputs.nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };

      carcosa = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit secrets;
        };

        inherit system;

        modules = [
          ./hosts/carcosa
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.default
          inputs.noctalia-greeter.nixosModules.default
          ./hosts/carcosa/preservation.nix
          ./hosts/carcosa/disko.nix
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

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dymdym = import ./home;

              extraSpecialArgs = {
                  inherit inputs;
              };
              sharedModules = [
                inputs.stylix.homeModules.stylix
                inputs.niri.homeModules.niri
                inputs.noctalia.homeModules.default
                inputs.nixvim.homeModules.nixvim
                inputs.hermes-agent.homeManagerModules.default
              ];
            };
          }

        ];
      };

      rlyeh = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit secrets;
        };

        inherit system;

        modules = [
          ./hosts/rlyeh
          inputs.noctalia-greeter.nixosModules.default
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

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dymdym = import ./home;

              sharedModules = [
                inputs.stylix.homeModules.stylix
                inputs.niri.homeModules.niri
                inputs.noctalia.homeModules.default
                inputs.nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };

      midian = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit secrets;
        };

        inherit system;

        modules = [
          ./hosts/midian
          inputs.disko.nixosModules.disko
          inputs.noctalia-greeter.nixosModules.default
          # inputs.preservation.nixosModules.default
          # ./hosts/midian/preservation.nix
          ./hosts/midian/disko.nix
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

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dymdym = import ./home;

              sharedModules = [
                inputs.stylix.homeModules.stylix
                inputs.niri.homeModules.niri
                inputs.noctalia.homeModules.default
                inputs.nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://hermes-agent.cachix.org"
      "https://cache.nixos-cuda.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "hermes-agent.cachix.org-1:jN3pjR50Mxi4SESKC/FIMNM6/LCosvPk2VUwzVvebzU="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
